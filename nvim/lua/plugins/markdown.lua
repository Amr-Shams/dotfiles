return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown" },
    },
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app; npm install",
    init = function()
      vim.g.mkdp_browser = "wslview" -- This is the best way if wsl-utils is installed
      -- Fallback to powershell start if wslview isn't there
      if vim.fn.executable("wslview") == 0 then
        vim.g.mkdp_browser = "powershell.exe -c start"
      end
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
  },
}
