-- ~/.config/nvim/lua/plugins/suda.lua
return {
  "lambdalisue/vim-suda",
  -- load only when you invoke a sudo command
  cmd = { "SudaRead", "SudaWrite" },
  -- optional: delay setup until after reading a buffer
  -- event = "BufReadPre",
  -- if you want to add keymaps or extra config:
  config = function()
    -- for example, map <leader>fs to write with sudo
    vim.keymap.set("n", "<leader>fs", ":SudaWrite<CR>", { desc = "Save file with sudo" })
  end,
}

