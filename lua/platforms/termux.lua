-- -- Grab the machine’s architecture by calling uname -m
-- local handle = io.popen("uname -m")
-- local arch = ""
-- if handle then
--   arch = handle:read("*l") or ""
--   handle:close()
-- end
--
-- -- print(handle)
--
-- -- If the result contains "arm" (covers armv7l, aarch64, etc.), apply the ARM-only settings
-- local arch_l = arch:lower()
-- if arch_l == "aarch64" or arch_l:find("arm", 1, true) then
--   -- print("Bot Android detected")
--   -- Use bash as the shell
--   -- vim.opt.shell = "/bin/bash"
--
--   -- Make sure bash is launched in interactive mode (-i)
--   vim.opt.shellcmdflag = "--rcfile /data/data/com.termux/files/home/.bashrc -ic"
-- end
