return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = { "nvim-treesitter/playground" },
  config = function()
    -- 1) First, load your colorscheme (if you do it here).
    --    If you do it elsewhere (e.g. in init.lua), just be sure
    --    this next part runs _after_ that.
    -- vim.cmd("colorscheme tokyonight")  -- for example

    -- 2) Set up Treesitter
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "html",
        "css",
        "scss",
        "svelte",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        custom_captures = {
          ["custom.component"] = "TSCustomComponent",
        },
      },
      playground = { enable = true },
    })

    -- 3) _After_ the above, define your custom highlight group in orange:
    --    we set both GUI and terminal colors
    vim.api.nvim_set_hl(0, "TSCustomComponent", {
      fg = "#FFA500",
      ctermfg = 214,
      gui = nil,
    })
  end,
}
