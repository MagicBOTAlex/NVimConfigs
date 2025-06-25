-- Early return unless we’re on Linux Mint
local function is_mint()
  local f = io.open("/etc/os-release", "r")
  if not f then return false end

  for line in f:lines() do
    if line:match("^ID=linuxmint")
        or line:match('^NAME="?Linux Mint"?') then
      f:close()
      return true
    end
  end

  f:close()
  return false
end

if not is_mint() then
  return
end

-- helper to keep things brief
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- in insert mode, Ctrl+Alt+7 => {
map('i', '<C-M-7>', '{', opts)
-- Ctrl+Alt+8 => [
map('i', '<C-M-8>', '[', opts)
-- Ctrl+Alt+9 => ]
map('i', '<C-M-9>', ']', opts)
-- Ctrl+Alt+0 => }
map('i', '<C-M-0>', '}', opts)
