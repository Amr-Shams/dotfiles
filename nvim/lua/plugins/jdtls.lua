return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    local jdtls = require('jdtls')

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_blink, blink = pcall(require, "blink.cmp")
    if has_blink then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end

    local function attach_jdtls()
      local bufnr = vim.api.nvim_get_current_buf()

      -- Check if buffer is valid and is a Java file
      if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype ~= "java" then
        return
      end

      local root_markers = { 'pom.xml', 'build.gradle', '.git', 'mvnw', 'gradlew' }
      local root_dir = require('jdtls.setup').find_root(root_markers)

      if root_dir == "" then
        return
      end

      local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
      local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name

      local config = {
        cmd = {
          'java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ERROR',
          '-Xms1g',
          '-Xmx2g',
          '-XX:+UseG1GC',
          '-XX:+UseStringDeduplication',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
          '-jar', vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
          '-configuration', vim.fn.stdpath('data') .. '/mason/packages/jdtls/config_linux',
          '-data', workspace_dir,
        },
        capabilities = capabilities,
        root_dir = root_dir,
        handlers = {
          ["textDocument/definition"] = function(err, result, ctx, config)
            if err then
              vim.api.nvim_err_writeln("LSP definition error: " .. err.message)
              return
            end
            if not result or vim.tbl_isempty(result) then
              print("Definition not found")
              return
            end

            local function load_and_jump(location)
              local uri = location.uri or location.targetUri
              if uri then
                local target_bufnr = vim.uri_to_bufnr(uri)
                vim.fn.bufload(target_bufnr)
                vim.lsp.util.jump_to_location(location, "utf-8")
              end
            end

            if vim.tbl_islist(result) then
              load_and_jump(result[1])
            else
              load_and_jump(result)
            end
          end,
        },
      }

      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(bufnr) then
          jdtls.start_or_attach(config)
        end
      end)
    end

    -- Attach to current buffer
    attach_jdtls()

    -- Attach to future buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = attach_jdtls,
    })
  end,
}