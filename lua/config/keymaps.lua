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

-- Visual-mode
map("v", "d", '"_d', opts)
map("v", "c", '"_c', opts)

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

-- Place cursor at selection end after yank
vim.keymap.set("v", "y", "y`>", { noremap = true, silent = true })

-- Make left alt + backslash exit terminal mode
vim.keymap.set("t", "<M-<>", [[<C-\><C-n>]], { noremap = true, silent = true })

local opts = { noremap = true, silent = true }

-- Normal-mode: Alt+Down / Alt+Up
vim.keymap.set("n", "<A-Down>", "<cmd>m .+1<CR>==", vim.tbl_extend("force", opts, { desc = "Move line down" }))
vim.keymap.set("n", "<A-Up>", "<cmd>m .-2<CR>==", vim.tbl_extend("force", opts, { desc = "Move line up" }))

-- Visual-mode block moves
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move block down" }))
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move block up" }))

-- Ctrl + s in insert mode to save
vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>", { silent = true })

-- Remap PageDown to half-page down
vim.keymap.set({ "n", "v" }, "<PageDown>", "<C-d>", { silent = true, desc = "Half-page down" })
-- Remap PageUp   to half-page up
vim.keymap.set({ "n", "v" }, "<PageUp>", "<C-u>", { silent = true, desc = "Half-page up" })


-- ──────────────────────────────────────────────────────────────
-- 1) Git pull in the current working directory
-- ──────────────────────────────────────────────────────────────
-- Pressing <leader> g p will run "git pull" in whatever
-- directory Neovim was opened from (or has as its current dir).

vim.keymap.set(
  "n",                                 -- mode: normal
  "<leader>gp",                        -- key sequence
  ":!git pull<CR><CR>",                -- command to run
  { silent = true, desc = "Git pull (cwd)" }
)


-- ──────────────────────────────────────────────────────────────
-- 2) Git pull in your Neovim config directory
-- ──────────────────────────────────────────────────────────────
-- Pressing <leader> g c will run "git pull" inside ~/.config/nvim.

vim.keymap.set(
  "n",                                 -- mode: normal
  "<leader>gc",                        -- key sequence
  ":!git -C " .. vim.fn.expand("$HOME") .. "/.config/nvim pull<CR><CR>",
  { silent = true, desc = "Git pull (nvim config)" }
)
