return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  opts = {
    -- Core
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },

    -- Git features (YOU USE THESE)
    git = { enabled = true },
    gitbrowse = { enabled = true },
    lazygit = { enabled = true },

    -- Picker
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<C-c>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    },

    -- Styles
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
  },

  keys = {
    { "<leader>un", function() Snacks.notifier.hide() end,      desc = "Dismiss Notifications" },
    { "<leader>bd", function() Snacks.bufdelete() end,          desc = "Delete Buffer" },

    -- Git
    { "<leader>gg", function() Snacks.lazygit() end,            desc = "Lazygit" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end,   desc = "Lazygit File History" },
    { "<leader>gl", function() Snacks.lazygit.log() end,        desc = "Lazygit Log" },
    { "<leader>gb", function() Snacks.git.blame_line() end,     desc = "Git Blame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end,          desc = "Git Browse" },

    -- File ops
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },

    -- Terminal
    { "<C-/>",      function() Snacks.terminal() end,           desc = "Terminal" },
    { "<C-_>",      function() Snacks.terminal() end,           desc = "Terminal (alt)" },
  },

  config = function(_, opts)
    require("snacks").setup(opts)

    -- Debug helpers
    _G.dd = function(...) Snacks.debug.inspect(...) end
    _G.bt = function() Snacks.debug.backtrace() end
    vim.print = _G.dd

    -- Toggles
    Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>us")
    Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>uw")
    Snacks.toggle.option("relativenumber", { name = "relative number" }):map("<leader>uL")
    Snacks.toggle.diagnostics():map("<leader>ud")
    Snacks.toggle.line_number():map("<leader>ul")
    Snacks.toggle.treesitter():map("<leader>uT")
    Snacks.toggle.option("background", {
      off = "light",
      on = "dark",
      name = "dark background",
    }):map("<leader>ub")

    if vim.lsp.inlay_hint then
      Snacks.toggle.inlay_hints():map("<leader>uh")
    end
  end,
}
