return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura" -- or "skim", etc.
    vim.g.tex_conceal = "abdmg" -- show conceal features
    vim.opt.conceallevel = 2
  end,
}
