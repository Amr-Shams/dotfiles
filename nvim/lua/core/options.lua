local opt = vim.opt

local function clipboard_provider()
  local wayland_socket
  if vim.env.WAYLAND_DISPLAY and vim.env.XDG_RUNTIME_DIR then
    wayland_socket = vim.env.XDG_RUNTIME_DIR .. "/" .. vim.env.WAYLAND_DISPLAY
  end

  local has_wayland = wayland_socket and vim.loop.fs_stat(wayland_socket) ~= nil
  local has_x11 = vim.env.DISPLAY

  if vim.fn.executable("wal-copy") == 1 and vim.fn.executable("wal-paste") == 1 then
    return {
      name = "wal-clipboard",
      copy = {
        ["+"] = "wal-copy",
        ["*"] = "wal-copy",
      },
      paste = {
        ["+"] = "wal-paste",
        ["*"] = "wal-paste",
      },
      cache_enabled = 1,
    }
  end

  if has_wayland and vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") == 1 then
    return {
      name = "wayland-clipboard",
      copy = {
        ["+"] = "wl-copy --foreground --type text/plain",
        ["*"] = "wl-copy --primary --foreground --type text/plain",
      },
      paste = {
        ["+"] = "wl-paste --no-newline",
        ["*"] = "wl-paste --primary --no-newline",
      },
      cache_enabled = 1,
    }
  end

  if vim.fn.has("wsl") == 1 then
    return {
      name = "wsl-clipboard",
      copy = {
        ["+"] = "clip.exe",
        ["*"] = "clip.exe",
      },
      paste = {
        ["+"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace('`r`n', '`n'))",
        ["*"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace('`r`n', '`n'))",
      },
      cache_enabled = 1,
    }
  end

  if has_x11 and vim.fn.executable("xsel") == 1 then
    return {
      name = "xsel-clipboard",
      copy = {
        ["+"] = "xsel --clipboard --input",
        ["*"] = "xsel --primary --input",
      },
      paste = {
        ["+"] = "xsel --clipboard --output",
        ["*"] = "xsel --primary --output",
      },
      cache_enabled = 1,
    }
  end

  if has_x11 and vim.fn.executable("xclip") == 1 then
    return {
      name = "xclip-clipboard",
      copy = {
        ["+"] = "xclip -quiet -i -selection clipboard",
        ["*"] = "xclip -quiet -i -selection primary",
      },
      paste = {
        ["+"] = "xclip -o -selection clipboard",
        ["*"] = "xclip -o -selection primary",
      },
      cache_enabled = 1,
    }
  end

  return nil
end

vim.g.clipboard = clipboard_provider()

-- Line numbers
opt.number = true
opt.relativenumber = true

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undodir")

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Visual
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
-- opt.colorcolumn = "80"  -- Removed this line to eliminate the column
opt.cursorline = true

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Timing
opt.updatetime = 50
opt.timeoutlen = 300

-- Performance
opt.lazyredraw = true
opt.ttyfast = true
opt.regexpengine = 1
