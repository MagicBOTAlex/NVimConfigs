local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<M-Left>", "<C-o>", opts) -- Alt + Left = Jump back
map("n", "<M-Right>", "<C-i>", opts) -- Alt + Right = Jump forward

local function goto_buffer(index)
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  if buffers[index] then
    vim.cmd("buffer " .. buffers[index].bufnr)
  end
end

for i = 1, 9 do
  vim.keymap.set("n", "<leader>b" .. i, function()
    goto_buffer(i)
  end, { desc = "Go to buffer " .. i })
end

vim.api.nvim_create_user_command("Q", "q", {})
