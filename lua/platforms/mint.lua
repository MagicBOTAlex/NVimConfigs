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

local map  = vim.keymap.set
local opts = { noremap = true, silent = true }

-- your existing insert-mode mappings
map('i', '<C-M-7>', '{}<Left>', opts)
map('i', '<C-M-8>', '[]<Left>', opts)
map('i', '<C-M-9>', ']', opts)
map('i', '<C-M-0>', '}', opts)

-- now add the same keys in normal/visual/operator-pending so you can do ci[, di{, etc.
map({'n','v','o'}, '<C-M-8>', '[', opts)  -- Alt+Ctrl+8 → “[”
map({'n','v','o'}, '<C-M-9>', ']', opts)  -- Alt+Ctrl+9 → “]”
map({'n','v','o'}, '<C-M-7>', '{', opts)  -- Alt+Ctrl+7 → “{”
map({'n','v','o'}, '<C-M-0>', '}', opts)  -- Alt+Ctrl+0 → “}”
