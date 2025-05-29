-- ~/.config/nvim/lua/plugins/flash.lua
return {
  "folke/flash.nvim",
  opts = {
    modes = {
      treesitter = {
        jump = {
          pos = "start",
          autojump = true,
        },
      },
    },
  },
}
