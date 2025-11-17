return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "neanias/everforest-nvim",
    version = false,      -- latest
    lazy = false,         -- load on startup
    priority = 1000,      -- load before other plugins
    config = function()
      require("everforest").setup({
        -- tweak these if you want
        background = "medium",             -- "soft", "medium", "hard"
        transparent_background_level = 0,  -- 0, 1, or 2
        italics = true,
      })
    end,
  },

  -- Tell LazyVim to use this colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}

