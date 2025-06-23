return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local ok, codeium = pcall(require, "codeium")
    if not ok then return end

    codeium.setup({ enable_chat = true })

    local keymap = vim.keymap.set

    if codeium.accept then
      keymap("i", "<C-g>", codeium.accept, { desc = "Accept Codeium Suggestion" })
    end

    if codeium.cycle_completions then
      keymap("i", "<C-]>", function() codeium.cycle_completions(1) end, { desc = "Next Suggestion" })
      keymap("i", "<C-[>", function() codeium.cycle_completions(-1) end, { desc = "Prev Suggestion" })
    end

    if codeium.clear then
      keymap("i", "<C-c>", codeium.clear, { desc = "Clear Codeium" })
    end

    if codeium.complete then
      keymap("i", "<C-\\>", codeium.complete, { desc = "Trigger Codeium" })
    end

    if codeium.chat then
      keymap("n", "<leader>cc", codeium.chat, { desc = "Open Codeium Chat" })
    end
  end,
}
