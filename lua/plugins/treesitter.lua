return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
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
      },
      playground = {
        enable = true,
      },
    },
  },
}
