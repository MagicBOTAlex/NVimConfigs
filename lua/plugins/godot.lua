return {
  {
    "lommix/godot.nvim",
    lazy = true,
    -- Trigger loading automatically when opening Godot files
    ft = { "gdscript", "gdscript3", "csharp" }, 
    config = function()
      require("godot").setup({
bin = "godot-mono"
      })
    end,
  },
}
