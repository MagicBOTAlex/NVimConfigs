-- Alt + left and right for back and front
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<M-Left>", "<C-o>", opts) -- Alt + Left = Jump back
map("n", "<M-Right>", "<C-i>", opts) -- Alt + Right = Jump forward

-- Make not copy by default
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Hide the mouse pointer while typing; it will reappear on the next mouse move
vim.opt.mousehide = true

-- Normal-mode
map("n", "d", '"_d', opts)
map("n", "c", '"_c', opts)
map("n", "x", '"_x', opts)

-- Visual-mode
map("v", "d", '"_d', opts)
map("v", "c", '"_c', opts)
map("v", "x", '"_x', opts)

-- Change buffers from 0-9 to 1-9 i think
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

-- Makes the typo :Q also work
vim.api.nvim_create_user_command("Q", "q", {})

-- Opens OS file explorer from Space + E
vim.keymap.set("n", "<leader>E", function()
  local path = vim.fn.expand("%:p:h")

  -- Detect OS and open accordingly
  local cmd
  if vim.fn.has("win32") == 1 then
    cmd = { "cmd.exe", "/C", "start", path }
  elseif vim.fn.has("unix") == 1 then
    cmd = { "xdg-open", path }
  else
    vim.notify("Unsupported OS for file explorer", vim.log.levels.WARN)
    return
  end

  vim.fn.jobstart(cmd, { detach = true })
end, { desc = "Open file location in system file explorer" })

-- Bring back Ctrl + key in insertmode

vim.keymap.set("i", "<C-Left>", "<C-\\><C-O>b", { desc = "Move to previous word in insert mode" })
vim.keymap.set("i", "<C-Right>", "<C-\\><C-O>w", { desc = "Move to next word in insert mode" })
vim.keymap.set("i", "<C-Del>", "<C-\\><C-O>dw", { desc = "Delete next word in insert mode" })
vim.keymap.set("i", "<C-h>", "<C-w>", { desc = "Delete previous word" })
