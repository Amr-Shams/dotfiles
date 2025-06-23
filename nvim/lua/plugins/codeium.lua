-- Codeium AI assistant configuration with smart Tab completion
return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      enable_chat = true,
    })
    
    local keymap = vim.keymap.set
    
    -- Smart Tab function that handles both cmp and codeium
    local function smart_tab()
      local cmp = require('cmp')
      
      -- Check if cmp menu is visible
      if cmp.visible() then
        return cmp.confirm({ select = true })
      end
      
      -- Check if there's a Codeium suggestion
      if vim.fn["codeium#Accept"]() ~= "" then
        return vim.fn["codeium#Accept"]()
      end
      
      -- Check if we can expand a snippet
      local luasnip = require('luasnip')
      if luasnip.expandable() then
        return luasnip.expand()
      end
      
      -- Check if we can jump forward in a snippet
      if luasnip.jumpable(1) then
        return luasnip.jump(1)
      end
      
      -- Fallback to regular tab
      return "<Tab>"
    end
    
    -- Smart Shift-Tab for going backwards
    local function smart_s_tab()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      -- If cmp menu is visible, go to previous item
      if cmp.visible() then
        return cmp.select_prev_item()
      end
      
      -- If we can jump backwards in snippet, do it
      if luasnip.jumpable(-1) then
        return luasnip.jump(-1)
      end
      
      -- Fallback to regular shift-tab
      return "<S-Tab>"
    end
    
    -- Set up the smart tab mappings
    keymap("i", "<Tab>", smart_tab, { expr = true, desc = "Smart Tab (cmp/codeium/snippet)" })
    keymap("i", "<S-Tab>", smart_s_tab, { expr = true, desc = "Smart Shift-Tab (cmp/snippet)" })
    
    -- Alternative keymaps for Codeium control
    keymap("i", "<C-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, desc = "Next Codeium suggestion" })
    keymap("i", "<C-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, desc = "Previous Codeium suggestion" })
    keymap("i", "<C-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, desc = "Clear Codeium suggestion" })
    
    -- Accept Codeium suggestion with Ctrl+Y (alternative to Tab)
    keymap("i", "<C-y>", function() return vim.fn["codeium#Accept"]() end, { expr = true, desc = "Accept Codeium suggestion" })
    
    -- Chat functionality
    keymap("n", "<leader>cc", ":Codeium Chat<CR>", { desc = "Open Codeium Chat" })
  end,
}