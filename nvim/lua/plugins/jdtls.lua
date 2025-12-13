return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    local jdtls = require('jdtls')

    local config = {
      cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration', vim.fn.stdpath('data') .. '/mason/packages/jdtls/config_linux',
        '-data', vim.fn.stdpath('data') .. '/jdtls-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'),
      },
      root_dir = require('lspconfig.util').root_pattern('pom.xml', 'build.gradle', '.git', 'mvnw', 'gradlew'),
      on_attach = function(client, bufnr)
        jdtls.setup_dap({ hotcodereplace = 'auto' })
      end,
    }

    jdtls.start_or_attach(config)
  end,
}
