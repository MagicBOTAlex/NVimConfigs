local is_windows = vim.loop.os_uname().sysname:match("Windows")
if not is_windows then
  return
end

local file = "shada/main.shada.tmp.X"
local path = vim.fn.stdpath("data") .. "/" .. file

local stat = vim.loop.fs_stat(path)
if stat then
  local ok, err = os.remove(path)
  if not ok then
    print("Failed to delete file: " .. err)
  end
end

-- -- OSC-52 clipboard
-- vim.g.clipboard = {
--   name = "OSC 52",
--   copy = {
--     ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
--     ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
--   },
--   paste = {
--     ["+"] = function() end,
--     ["*"] = function() end,
--   },
-- }
