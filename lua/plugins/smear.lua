local function is_on_battery()
  local sys = (vim.uv or vim.loop).os_uname().sysname

  if sys == "Linux" then
    -- 1. Check any AC adapter path (matches AC, ADP0, ACAD, ADP1, etc.)
    local ac_paths = vim.fn.glob("/sys/class/power_supply/A*/online", true, true)
    for _, path in ipairs(ac_paths) do
      local f = io.open(path, "r")
      if f then
        local online = f:read("*all"):gsub("%s+", "")
        f:close()
        return online == "0"
      end
    end

    -- 2. Fallback check for any Battery state (BAT0, BAT1, etc.)
    local bat_paths = vim.fn.glob("/sys/class/power_supply/BAT*/status", true, true)
    for _, path in ipairs(bat_paths) do
      local f = io.open(path, "r")
      if f then
        local status = f:read("*all"):gsub("%s+", "")
        f:close()
        if status == "Discharging" then
          return true
        end
      end
    end
  elseif sys == "Darwin" then
    local handle = io.popen("pmset -g batt 2>/dev/null")
    if handle then
      local output = handle:read("*a")
      handle:close()
      return output:find("Battery Power") ~= nil
    end
  elseif sys == "Windows_NT" then
    local handle = io.popen('powershell -NoProfile -Command "(Get-WmiObject Win32_Battery).BatteryStatus" 2>nul')
    if handle then
      local output = handle:read("*a")
      handle:close()
      return output:find("1") ~= nil
    end
  end

  return false
end

return {
  "sphamba/smear-cursor.nvim",
  cond = function()
    -- Disable completely if on battery power
    if is_on_battery() then
      return false
    end

    -- Disable on large files (>1MB)
    local max_filesize = 1024 * 1024
    local ok, stats = pcall((vim.uv or vim.loop).fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > max_filesize then
      return false
    end

    return true
  end,
  opts = {
    stiffness = 0.8,
    trailing_stiffness = 0.5,
    stiffness_insert_mode = 0.7,
    trailing_stiffness_insert_mode = 0.7,
    damping = 0.8,
    distance_stop_animating = 0.5,
    time_interval = 30,
  },
}
