return {
  "nvim-treesitter/playground",
  cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  config = function()
    require("nvim-treesitter.configs").setup({
      playground = {
        enable = true, -- turn on the playground
        updatetime = 25, -- debounce time for highlighting
        persist_queries = false, -- don’t save queries between sessions
      },
    })
  end,
}
