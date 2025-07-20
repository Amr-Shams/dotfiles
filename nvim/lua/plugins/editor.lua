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
      -- REMOVED nvim-cmp integration since we use blink.cmp
    end,
  },


  -- Comments - FIXED keymaps
  {
    'numToStr/Comment.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('Comment').setup()

      -- Set up keymaps manually
      local keymap = vim.keymap.set
      keymap("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment" })
      keymap("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle comment" })
      keymap("n", "<leader>?", "<Plug>(comment_toggle_blockwise_current)", { desc = "Toggle block comment" })
      keymap("v", "<leader>?", "<Plug>(comment_toggle_blockwise_visual)", { desc = "Toggle block comment" })
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
