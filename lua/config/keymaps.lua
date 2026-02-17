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

-- Disable copy on delete
map("n", "d", '"_d', opts)
map("n", "c", '"_c', opts)
map("n", "D", '"_D', opts)
map("n", "C", '"_C', opts)

map("v", "d", '"_d', opts)
map("v", "c", '"_c', opts)
map("v", "D", '"_D', opts)
map("v", "C", '"_C', opts)

map("v", "xx", '"+dd', opts)
map("n", "xx", '"+dd', opts)

-- Normal mode
vim.keymap.set('n', 'y', '"+y', opts)
vim.keymap.set('n', 'yy', '"+yy', opts) 
vim.keymap.set('n', 'Y', '"+Y', opts)

-- Visual/selection mode
vim.keymap.set('v', 'y', '"+y', opts)
vim.keymap.set('x', 'y', '"+y', opts)


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

-- Exit terminal mode with ½
vim.api.nvim_set_keymap("t", "½", "<C-\\><C-n>", { noremap = true, silent = true })

local opts = { noremap = true, silent = true }

-- Normal-mode: Alt+Down / Alt+Up (no reindent)
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>", vim.tbl_extend("force", opts, { desc = "Move line down" }))
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>", vim.tbl_extend("force", opts, { desc = "Move line up" }))

-- Visual-mode block moves (keep selection, no reindent)
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv", vim.tbl_extend("force", opts, { desc = "Move block down" }))
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv", vim.tbl_extend("force", opts, { desc = "Move block up" }))

-- Duplicate current line
vim.keymap.set("n", "<M-d>", function()
  vim.cmd([[normal! "dyy"dp]])
end, { silent = true, desc = "Duplicate line" })

-- Duplicate current selection (works for char/line/block visual)
vim.keymap.set("x", "<M-d>", function()
  vim.cmd([[normal! y`>p]])
end, { silent = true, desc = "Duplicate selection" })

-- Ctrl + s in insert mode to save
vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>", { silent = true })

-- Remap PageDown to half-page down
vim.keymap.set({ "n", "v" }, "<PageDown>", "<C-d>", { silent = true, desc = "Half-page down" })
-- Remap PageUp   to half-page up
vim.keymap.set({ "n", "v" }, "<PageUp>", "<C-u>", { silent = true, desc = "Half-page up" })

-- Ctrl+Down/Up = half-page down/up (same as <C-d>/<C-u>)
vim.keymap.set({ "n", "x" }, "<C-Down>", "<C-d>", { silent = true, desc = "Half-page down" })
vim.keymap.set({ "n", "x" }, "<C-Up>", "<C-u>", { silent = true, desc = "Half-page up" })

-- Ctrl+Shift+C → yank to system clipboard ("+ register)
vim.keymap.set({ "n", "x" }, "<C-c>", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })

-- Resize step in cells
local step = 3

-- Works in GUIs and in terminals that pass Ctrl+Shift+Arrows through
vim.keymap.set("n", "<S-A-Left>", function()
  vim.cmd("vertical resize -" .. step)
end, { desc = "Narrow window" })
vim.keymap.set("n", "<S-A-Right>", function()
  vim.cmd("vertical resize +" .. step)
end, { desc = "Widen window" })
vim.keymap.set("n", "<S-A-Up>", function()
  vim.cmd("resize +" .. step)
end, { desc = "Taller window" })
vim.keymap.set("n", "<S-A-Down>", function()
  vim.cmd("resize -" .. step)
end, { desc = "Shorter window" })

-- ──────────────────────────────────────────────────────────────
-- 1) Git pull in the current working directory
-- ──────────────────────────────────────────────────────────────
-- Pressing <leader> g p will run "git pull" in whatever
-- directory Neovim was opened from (or has as its current dir).

vim.keymap.set(
  "n", -- mode: normal
  "<leader>gp", -- key sequence
  ":!git pull<CR><CR>", -- command to run
  { silent = true, desc = "Git pull (cwd)" }
)

-- ──────────────────────────────────────────────────────────────
-- 2) Git pull in your Neovim config directory
-- ──────────────────────────────────────────────────────────────
-- Pressing <leader> g c will run "git pull" inside ~/.config/nvim.

local cfg = vim.fn.stdpath("config")
vim.keymap.set(
  "n",
  "<leader>gc",
  string.format(":!git -C %s pull<CR><CR>", cfg),
  { silent = true, desc = "Git pull (nvim config)" }
)

vim.keymap.set({ "n", "x" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })

vim.keymap.set("o", "s", function()
  if vim.v.operator == "d" then
    return "s" -- literal 's', passed through
  end
  require("flash").jump()
  return "" -- consume the key
end, { expr = true, desc = "Flash (op)", replace_keycodes = false })

-- double-v ⇒ visual block
vim.keymap.set("n", "vv", "<C-v>", { noremap = true, silent = true, desc = "Enter Visual-Block mode" })

-- Allows 2o for insert 2 lines below and enter insert mode
local feedkeys = vim.api.nvim_feedkeys
local t = vim.api.nvim_replace_termcodes

-- helper: open N lines with {key} (either "o" or "O")
local function smart_open(key)
  local cnt = vim.v.count
  -- for each extra count, open one line and immediately go back to normal
  for _ = 2, cnt do
    feedkeys(t(key .. "<Esc>", true, false, true), "n", false)
  end
  -- final open: drops you into insert mode
  feedkeys(t(key, true, false, true), "n", false)
end

-- map both 'o' (below) and 'O' (above)
for _, key in ipairs({ "o", "O" }) do
  vim.keymap.set("n", key, function()
    smart_open(key)
  end, { noremap = true, silent = true })
end

-- make Ctrl-w + Ctrl-Arrow act like Ctrl-w + Arrow
map("n", "<C-w><C-Left>", "<C-w><Left>", { desc = "Move to left window" })
map("n", "<C-w><C-Right>", "<C-w><Right>", { desc = "Move to right window" })
map("n", "<C-w><C-Up>", "<C-w><Up>", { desc = "Move to upper window" })
map("n", "<C-w><C-Down>", "<C-w><Down>", { desc = "Move to lower window" })

-- cut inner-tag (yank & delete) with xit / xat
vim.keymap.set("n", "xit", [[yit"_dit]], { noremap = true, silent = true, nowait = true, desc = "Cut inside tag" })
vim.keymap.set("n", "xat", [[yat"_dat]], { noremap = true, silent = true, nowait = true, desc = "Cut around tag" })

-- E modification selection
local opts = { noremap = true, silent = true }
vim.keymap.set({ "n", "x", "o" }, "E", function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  -- get the text after the cursor
  local rest = line:sub(col + 2)
  -- find the next quote
  local qi = rest:find('"', 1, true)
  if qi then
    -- see what's between here and that quote
    local between = rest:sub(1, qi - 1)
    -- if there's NO space in there, we're on the last class/attribute piece
    if not between:find("%s") then
      return vim.cmd('normal! t"')
    end
  end
  -- otherwise, do normal E
  vim.cmd("normal! E")
end, opts)

vim.api.nvim_create_user_command(
  "W",
  function(opts)
    -- if you typed :W! then opts.bang is true, so we forward the bang
    vim.cmd("write" .. (opts.bang and "!" or ""))
  end,
  { bang = true } -- allow :W!
)

-- <leader>uW to toggle warnings
local warnings_visible = true
vim.keymap.set("n", "<leader>uW", function()
  warnings_visible = not warnings_visible
  
  -- If visible, show everything (nil). If not, show only ERRORs.
  local severity_filter = warnings_visible and nil or { min = vim.diagnostic.severity.ERROR }

  vim.diagnostic.config({
    virtual_text = { severity = severity_filter },
    signs = { severity = severity_filter },
    underline = { severity = severity_filter },
  })

  local msg = warnings_visible and "Enabled Warnings" or "Disabled Warnings (Errors only)"
  vim.notify(msg, vim.log.levels.INFO, { title = "Diagnostics" })
end, { desc = "Toggle Warnings" })

-- Open terminal in current file
vim.keymap.set("n", "<leader>cT", function()
  Snacks.terminal(nil, { cwd = vim.fn.expand("%:p:h") })
end, { desc = "Terminal (Current File Dir)" })
