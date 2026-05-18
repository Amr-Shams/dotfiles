return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    config = function()
      local ok, smear = pcall(require, "smear_cursor")
      if not ok then
        return
      end
      smear.setup({})
    end,
  },
}
