vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Auto-start fish inside Nix Shells",
  group = vim.api.nvim_create_augroup("NixShellFish", { clear = true }),
  pattern = "*", -- Matches all terminal buffers
  callback = function()
    -- Check if the IN_NIX_SHELL environment variable is set
    if vim.env.IN_NIX_SHELL then
      -- Get the current buffer's job ID
      local job_id = vim.b.terminal_job_id

      -- Helper: Check if the terminal is running a shell (bash/zsh/sh)
      -- We do this to prevent sending "fish" to a terminal running a specific tool
      -- (like lazygit or python)
      local buf_name = vim.api.nvim_buf_get_name(0)
      local is_shell = buf_name:match("bash") or buf_name:match("zsh") or buf_name:match("sh")

      if job_id and is_shell then
        -- Send the command followed by Enter (\n)
        -- 'fish && exit' ensures that when you quit fish, the parent shell also closes.
        vim.api.nvim_chan_send(job_id, "fish && exit\n")

        -- Optional: clear the screen so you don't see the command text
        vim.api.nvim_chan_send(job_id, "clear\n")

        -- ensure we start in insert mode
        vim.cmd("startinsert")
      end
    end
  end,
})
