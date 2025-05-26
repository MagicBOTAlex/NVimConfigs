-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Default theme
vim.opt.termguicolors = true
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.cmd("colorscheme vscode")
  end,
})
-- after you set up Treesitter (or in your init.lua)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "svelte",
  callback = function()
    -- turn off the default HTML tag-name highlight
    vim.cmd([[ highlight clear htmlTagName ]])
    -- re-apply your custom component color in case the colorscheme reset it
    vim.api.nvim_set_hl(0, "@custom.component", {
      fg = "#4ec9b0",
      ctermfg = 214,
    })
  end,
})

-- ensure true‐color
vim.opt.termguicolors = true

local function fix_custom_component_hl()
  -- the “highlight!” forces a redefinition, even if it was linked
  vim.cmd([[
    highlight! TSCustomComponent guifg=#FFA500 ctermfg=214 gui=NONE
  ]])
end

-- apply now
fix_custom_component_hl()

-- re‐apply whenever a colorscheme is (re)loaded
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = fix_custom_component_hl,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "svelte",
  callback = function()
    -- clear the regex-based HTML tag highlights
    vim.cmd("highlight clear htmlTag")
    vim.cmd("highlight clear htmlTagN")
    -- then re-apply your orange group (in case colorscheme re-set things)
    vim.cmd("highlight! TSCustomComponent guifg=#FFA500 ctermfg=214 gui=NONE")
  end,
})
