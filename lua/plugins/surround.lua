return {
  "kylechui/nvim-surround",
  version = "*",
  config = function()
    require("nvim-surround").setup({
      -- remap surround “add” from gS to gs
      keymaps = {
        normal = "gs", -- add surroundings in normal mode
        visual = "gs", -- add surroundings in visual mode
        delete = "ds", -- delete surroundings
        change = "cs", -- change surroundings
      },
      surrounds = {
        ["{"] = {
          add = function()
            return { "{", "}" }
          end,
        },
      },
    })
  end,
}
