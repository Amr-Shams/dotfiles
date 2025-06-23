
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto-format on save for specific filetypes
augroup("AutoFormat", { clear = true })
autocmd("BufWritePre", {
  group = "AutoFormat",
  pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx", "*.rs", "*.go" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Close certain filetypes with q
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group = "CloseWithQ",
  pattern = {
    "qf", "help", "man", "notify", "lspinfo", "spectre_panel",
    "startuptime", "tsplayground", "PlenaryTestPopup"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

