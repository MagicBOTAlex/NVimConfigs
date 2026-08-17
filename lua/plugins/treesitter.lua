return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "html",
        "css",
        "scss",
        "svelte",
        "latex",
        "astro",
        "nix",
        "python",
        "go",
        "c",
        "vim",
        "vimdoc",
        "query",
      },
    },
    config = function(_, opts)
      -- 1. Install / track parsers
      local ts = require("nvim-treesitter")
      if type(ts.install) == "function" then
        ts.install(opts.ensure_installed)
      elseif type(ts.setup) == "function" then
        ts.setup(opts)
      end

      -- 2. Enable native Treesitter syntax highlighting on buffer load
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterAutoStart", { clear = true }),
        callback = function(args)
          -- Start treesitter highlighter safely if a parser exists
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      -- 3. Configure textobjects
      local ok_textobjects, textobjects = pcall(require, "nvim-treesitter-textobjects")
      if ok_textobjects and textobjects.setup then
        textobjects.setup({
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        })
      end

      -- 4. Custom highlight capture group:
      -- Modern Treesitter maps capture '@custom.component' directly to hl group '@custom.component'
      vim.api.nvim_set_hl(0, "@custom.component", {
        fg = "#FFA500",
        ctermfg = 214,
      })
      -- Retain legacy name link for backward compatibility
      vim.api.nvim_set_hl(0, "TSCustomComponent", { link = "@custom.component" })
    end,
  },
}
