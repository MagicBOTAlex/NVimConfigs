return {
  "ojroques/nvim-osc52",
  config = function()
    require("osc52").setup({
      max_length = 0,
      silent = false,
      trim = false,
    })

    -- Optional: Yank using leader+c
    local function copy()
      require("osc52").copy_register('"')
    end

    vim.keymap.set("v", "<leader>C", copy, { desc = "Copy to system clipboard (OSC52)" })
  end,
}
