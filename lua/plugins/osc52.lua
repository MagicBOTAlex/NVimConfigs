return {
  "ojroques/nvim-osc52",
  config = function()
    require("osc52").setup({
      max_length = 0, -- no limit
      silent = true,
      trim = false,
    })

    -- Copy in visual mode with <leader>c
    vim.keymap.set("v", "<leader>c", require("osc52").copy_visual, { desc = "Copy to clipboard (OSC52)" })

    -- Optional: make all yanks copy automatically
    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = function()
        if vim.v.event.operator == "y" and vim.v.event.regname == "" then
          require("osc52").copy_register("")
        end
      end,
    })
  end,
}
