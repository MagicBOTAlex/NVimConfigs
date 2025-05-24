-- Alt + left and right for back and front
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<M-Left>", "<C-o>", opts) -- Alt + Left = Jump back
map("n", "<M-Right>", "<C-i>", opts) -- Alt + Right = Jump forward

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

-- Default theme
vim.cmd([[colorscheme vscode]])
