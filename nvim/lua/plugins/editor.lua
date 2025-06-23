return {
  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Comments
  {
    'numToStr/Comment.nvim',

    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('Comment').setup({
        -- Add a space b/w comment and the line
        padding = true,
        -- Whether the cursor should stay at its position
        sticky = true,
        -- Lines to be ignored while (un)comment
        ignore = nil,
        -- LHS of toggle mappings in NORMAL mode
        toggler = {
          line = '<leader>/', -- Line-comment toggle keymap
          block = '<leader>?', -- Block-comment toggle keymap
        },
        -- LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          line = '<leader>/', -- Line-comment keymap
          block = '<leader>?', -- Block-comment keymap
        },
        -- LHS of extra mappings
        extra = {
          above = '<leader>cO', -- Add comment on the line above
          below = '<leader>co', -- Add comment on the line below
          eol = '<leader>cA', -- Add comment at the end of line
        },
        -- Enable keybindings
        -- NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
          -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          basic = false, -- Disable default basic mappings to avoid overlaps
          -- Extra mapping; `gco`, `gcO`, `gcA`
          extra = false, -- Disable default extra mappings to avoid overlaps
        },
      })
    end,
  },
  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },
}
