return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    require("telescope").load_extension("fzf")

    -- Telescope keymaps
    local builtin = require("telescope.builtin")
    local keymap = vim.keymap.set

    keymap("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
    keymap("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })
    keymap("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
    keymap("n", "<leader>ss", builtin.builtin, { desc = "Search Select Telescope" })
    keymap("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
    keymap("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
    keymap("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
    keymap("n", "<leader>s.", builtin.oldfiles, { desc = "Search Recent Files" })
    keymap("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })
  end,
}

---
