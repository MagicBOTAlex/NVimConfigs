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
