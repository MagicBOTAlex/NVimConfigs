-- ~/.config/nvim/lua/plugins/snacks.lua
return {
  {
    "folke/snacks.nvim",
    opts = {
      -- make sure explorer is enabled
      explorer = { enabled = true },
      terminal = {
        win = { position = "right" },
      },

      picker = {
        -- we only care about the explorer source here
        sources = {
          explorer = {
            auto_close = true,
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
        hidden = true,
exclude = {
        "*.uid",
        "*.tscn",
      },
      -- Boost priority for .cs files
      transform = function(item)
        if item.file and item.file:match("%.cs$") then
          -- Higher score means it bubbles to the top of the fuzzy match list
          item.score = (item.score or 1) + 100
        end
        return item
      -- Using a separate matcher logic ensure it still respects typed fuzzy matching
      end,
      },
      notifier = {
        enabled = true,
        top_down = false,
      },
    },
  },
}
