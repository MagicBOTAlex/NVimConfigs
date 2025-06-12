local uv = vim.loop

--- Return true if we’re ultimately under sshd, even after su
local function is_ssh_session()
  -- quick env‐var check
  if vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT or vim.env.SSH_TTY then
    return true
  end

  -- fallback: walk up parent processes looking for sshd
  local pid = uv.os_getpid()
  while pid and pid > 1 do
    local handle = io.popen(string.format("ps -p %d -o comm=,ppid=", pid))
    local info = handle:read("*l")
    handle:close()
    if not info then
      break
    end

    local name, ppid = info:match("^(%S+)%s+(%d+)")
    if name == "sshd" then
      return true
    end
    pid = tonumber(ppid)
  end

  return false
end

-- bail out if not an SSH session
if not is_ssh_session() then
  return
end

-- OSC-52 clipboard over SSH
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}
