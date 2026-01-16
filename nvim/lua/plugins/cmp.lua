return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "Exafunction/codeium.nvim",
    "L3MON4D3/luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "codeium" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })

    vim.api.nvim_create_user_command("CodeiumToggle", function()
      local config = cmp.get_config()
      local sources = config.sources
      local new_sources = {}
      local found = false

      for _, source in ipairs(sources) do
        if source.name == "codeium" then
          found = true
        else
          table.insert(new_sources, source)
        end
      end

      if not found then
        table.insert(new_sources, 1, { name = "codeium" })
        print("Codeium enabled")
      else
        print("Codeium disabled")
      end

      cmp.setup({ sources = new_sources })
    end, {})
  end,
}