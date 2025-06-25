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

local map   = vim.keymap.set
local opts  = { noremap = true, silent = true }

-- Ctrl+Alt+7 => insert "{}" then move left
map('i', '<C-M-7>', '{}<Left>', opts)
-- Ctrl+Alt+8 => insert "[]" then move left
map('i', '<C-M-8>', '[]<Left>', opts)
-- Ctrl+Alt+9 => insert "]}" then … well, for consistency:
map('i', '<C-M-9>', ']<Left>', opts)
-- Ctrl+Alt+0 => insert "{}" again if you like
map('i', '<C-M-0>', '}<Left>', opts)

