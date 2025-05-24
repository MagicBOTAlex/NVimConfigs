-- ~/.config/nvim/lua/plugins/snacks.lua
return {
  {
    "folke/snacks.nvim",
    opts = {
      -- make sure explorer is enabled
      explorer = { enabled = true },

      picker = {
        -- we only care about the explorer source here
        sources = {
          explorer = {
            layout = {
              preset = "sidebar",
              preview = false,

              -- this nested `layout` is what actually controls side/size
              layout = {
                position = "right",
                -- you can also set width here, e.g. width = 30
              },
            },
          },
        },
      },
    },
  },
}
