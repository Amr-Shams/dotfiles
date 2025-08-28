return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }
      }
    },
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<C-c>"] = { "close", mode = { "n", "i" } },
          }
        }
      }
    }
  },

  keys = {
    -- Define keymaps properly
    { "<leader>un", function() Snacks.notifier.hide() end,              desc = "Dismiss All Notifications" },
    { "<leader>bd", function() Snacks.bufdelete() end,                  desc = "Delete Buffer" },
    { "<leader>gg", function()
      print(vim.o.shell)
      Snacks.lazygit()
    end,                                                                desc = "Lazygit" },
    { "<leader>gb", function() Snacks.git.blame_line() end,             desc = "Git Blame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end,                  desc = "Git Browse" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end,           desc = "Lazygit Current File History" },
    { "<leader>gl", function() Snacks.lazygit.log() end,                desc = "Lazygit Log (cwd)" },
    { "<leader>cR", function() Snacks.rename.rename_file() end,         desc = "Rename File" },
    { "<c-/>",      function() Snacks.terminal() end,                   desc = "Terminal" },
    { "<c-_>",      function() Snacks.terminal() end,                   desc = "Terminal (alternative)" },
  },

  config = function(_, opts)
    require("snacks").setup(opts)

    -- Set up globals
    _G.dd = function(...) Snacks.debug.inspect(...) end
    _G.bt = function() Snacks.debug.backtrace() end
    vim.print = _G.dd

    -- Set up toggles
    Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>us")
    Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>uw")
    Snacks.toggle.option("relativenumber", { name = "relative number" }):map("<leader>uL")
    Snacks.toggle.diagnostics():map("<leader>ud")
    Snacks.toggle.line_number():map("<leader>ul")
    Snacks.toggle.treesitter():map("<leader>uT")
    Snacks.toggle.option("background", { off = "light", on = "dark", name = "dark background" }):map("<leader>ub")

    if vim.lsp.inlay_hint then
      Snacks.toggle.inlay_hints():map("<leader>uh")
    end
  end,
}
