return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_blink, blink = pcall(require, "blink.cmp")
    if has_blink then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end


    -- Configure LSP diagnostics to show warnings
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Setup diagnostic signs
    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Setup mason first
    require("mason").setup()

    -- Setup mason-lspconfig with the new API (remove automatic_enable)
    require("mason-lspconfig").setup({
      ensure_installed = {
        -- Language support
        "lua_ls",        -- Lua
        "pyright",       -- Python
        "ts_ls",         -- TypeScript/JavaScript
        "rust_analyzer", -- Rust
        "gopls",         -- Go
        "clangd",        -- C/C++
        "bashls",        -- Bash
        "clojure_lsp",   -- Clojure (Lisp)

        -- Web & config languages
        "html",        -- HTML
        "cssls",       -- CSS
        "tailwindcss", -- Tailwind CSS
        "eslint",      -- Linting for JS/TS
        "jsonls",      -- JSON
        "sqls",
      }
      ,
      automatic_installation = true,
      -- Remove automatic_enable - it's deprecated in v2
      handlers = {
        -- Default handler for all servers
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Specific server configurations
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
      },
    })

    -- LSP keymaps using LspAttach autocmd
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gr", vim.lsp.buf.references, "Goto References")
        map("gI", vim.lsp.buf.implementation, "Goto Implementation")
        map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")

        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- Fixed diagnostic keymaps
        map("<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
        map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
        map("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
        map("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")
      end,
    })
  end,
}
