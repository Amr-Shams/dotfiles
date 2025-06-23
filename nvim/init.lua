
-- Set leader keys early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configuration modules
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lazy")
