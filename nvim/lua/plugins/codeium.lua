return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  event = 'BufEnter',
  config = function()
    require("codeium").setup({})
    -- Disable default keybindings
    vim.g.codeium_disable_bindings = 1

    -- Set custom keybindings
    vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-]>', function() return vim.fn['codeium#CycleCompletions'](1) end,
      { expr = true, silent = true })
    vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })

    -- Enable/disable keybindings
    vim.keymap.set('n', '<leader>ce', function() return vim.fn['codeium#Disable']() end,
      { expr = true, desc = 'Disable Codeium' })
    vim.keymap.set('n', '<leader>cd', function() return vim.fn['codeium#Enable']() end,
      { expr = true, desc = 'Enable Codeium' })
  end
}
