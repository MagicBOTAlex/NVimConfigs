-- ~/.config/nvim/lua/platforms/init.lua

-- Determine the absolute path to the 'lua/platforms' folder
local config_path = vim.fn.stdpath("config") -- e.g. "~/.config/nvim"
local folder = config_path .. "/lua/platforms" -- e.g. "~/.config/nvim/lua/platforms"

-- globpath with 'true' as the 4th argument returns a Lua table (list) of matches
-- each entry in this table is a full filename like "/home/you/.config/nvim/lua/platforms/ssh.lua"
local files = vim.fn.globpath(folder, "*.lua", false, true)

for _, fullpath in ipairs(files) do
  -- Extract just the filename without extension, e.g. "ssh" from ".../platforms/ssh.lua"
  local filename = vim.fn.fnamemodify(fullpath, ":t:r")

  -- Skip this file itself (init.lua)
  if filename ~= "init" then
    -- Require "platforms.<filename>"
    -- (Neovim knows that anything under ~/.config/nvim/lua is on the Lua module path)
    require("platforms." .. filename)
  end
end
