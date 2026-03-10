local uv = vim.loop

local function is_ssh_session()
  -- 1. Check standard environment variables first
  if vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT or vim.env.SSH_TTY then
    return true
  end

  -- 2. Check for SSH_AUTH_SOCK (common when forwarding agents)
  if vim.env.SSH_AUTH_SOCK then
    return true
  end

  -- 3. Robust PID Walking
  local pid = uv.os_getpid()
  while pid and pid > 1 do
    -- Use 'ps -p <pid> -o comm=' to get the command name
    local handle = io.popen(string.format("ps -p %d -o comm=,ppid=", pid))
    if not handle then break end
    
    local info = handle:read("*l")
    handle:close()
    if not info then break end

    -- Use a more flexible match to handle "sshd: user@pts"
    local name, ppid = info:match("^(%S+)%s+(%d+)")
    if name and name:find("sshd") then 
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

vim.schedule(function()
    if _G.Snacks and Snacks.notifier then
      Snacks.notifier.notify("OSC 52 Clipboard Enabled", "info", {
        title = "Platform: SSH",
        icon = "󰒍",
      })
    else
      -- Fallback if Snacks isn't ready
      print("SSH Platform: OSC 52 Enabled")
    end
  end)

  -- 1. Define a robust copy function
local function osc52_copy(lines, _)
    -- Join lines and encode to base64 using Neovim's built-in function
    local content = table.concat(lines, '\n')
    local base64 = vim.base64.encode(content)
    
    -- Construct the OSC-52 sequence
    local osc = string.format('\27]52;c;%s\7', base64)
    
    -- Write directly to the terminal's stderr channel
    vim.api.nvim_chan_send(vim.v.stderr, osc)
end

-- 2. Register the provider correctly
vim.g.clipboard = {
    name = 'osc52',
    copy = {
        ['+'] = osc52_copy,
        ['*'] = osc52_copy,
    },
    paste = {
        ['+'] = function() return vim.fn.getreg('+') end,
        ['*'] = function() return vim.fn.getreg('*') end,
    },
}

-- 3. The "Magic" link: sync default yank to the '+' register
vim.opt.clipboard = 'unnamedplus'
