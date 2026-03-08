local function is_mint()
  local f = io.open("/etc/os-release", "r")
  if not f then return false end

  for line in f:lines() do
    if line:match("^ID=nixos")
        or line:match('^NAME="?NixOS"?') then
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


-- Link to nvim things
-- vim.opt.rtp:prepend("/run/current-system/sw/share/nvim/site/pack/dist/start/nvim-treesitter-textobjects")
