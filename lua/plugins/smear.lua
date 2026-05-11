return {
  "sphamba/smear-cursor.nvim",
  -- The enabled function determines if the plugin loads
  enabled = function()
    local max_filesize = 1024 * 1024 -- 1MB threshold
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
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
