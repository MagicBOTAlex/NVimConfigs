return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    -- 1. Setup custom surroundings and options
    require("nvim-surround").setup({
      surrounds = {
        ["{"] = {
          add = { "{", "}" },
        },
      },
    })

    -- 2. Define custom keymaps via <Plug> mappings
    -- Normal mode: add surroundings (replaces default 'ys' with 'gs')
    vim.keymap.set("n", "gs", "<Plug>(nvim-surround-normal)", { desc = "Add surround" })

    -- Visual mode: add surroundings (replaces default 'S' / 'gS' with 'gs')
    vim.keymap.set("x", "gs", "<Plug>(nvim-surround-visual)", { desc = "Add surround" })

    -- Normal mode: delete surroundings ('ds')
    vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete surround" })

    -- Normal mode: change surroundings ('cs')
    vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)", { desc = "Change surround" })
  end,
}
