return {
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
        -- Basic settings only
        debounceMs = 500,
        minSearchChars = 2,
        staticTitle = 'Find and Replace',
        transient = false,
      })

      -- Simple keymaps
      local grug = require('grug-far')

      -- Open find and replace
      vim.keymap.set('n', '<leader>sr', grug.open, { desc = 'Find and Replace' })

      -- Find word under cursor
      vim.keymap.set('n', '<leader>sw', function()
        grug.open({ prefills = { search = vim.fn.expand('<cword>') } })
      end, { desc = 'Find word under cursor' })
    end
  } }
