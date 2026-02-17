return {
  -- 1. Ensure Treesitter has the Svelte parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- add "svelte" to the list of languages to install
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "javascript",
        "typescript",
        "html",
        "css",
        "svelte", -- ← here
        -- … any others you already have
      },
      highlight = {
        enable = true,
        -- You can disable slow parsers here, but svelte is usually fine
      },
      indent = {
        enable = true,
      },
      -- if you use autotag:
      autotag = {
        enable = true,
      },
    },
  },

  -- 2. Configure nvim-lspconfig to start the Svelte Language Server
  {
    "neovim/nvim-lspconfig",
    -- merge into LazyVim’s default LSP opts
    opts = {
      servers = {
        -- your existing tailwindcss setup
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { [[class[:]?%s*[:=]?%s*["'`]([^"'`}]*)["'`}]], 1 },
                },
              },
            },
          },
        },
        -- add Svelte here
        svelte = {
          -- you can pass any server-specific settings here;
          -- empty table is fine if you just want defaults
        },

        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                autoImportCompletions = true,
                diagnosticSeverityOverrides = {
                  reportUninitializedInstanceVariable = "none",
                  reportUnknownParameterType = "none",
                  reportUnknownMemberType = "none",
                  reportUnknownVariableType = "none",
                  reportUnknownArgumentType = "none",
                  reportUnusedCallResult = "none",
                  reportUnusedVariable = "none",
                  reportAny = "none",
                  reportMissingParameterType = "none",
                },
              },
            },
          },
        },

      },
      -- some LazyVim setups need a `setup` override so the server actually spawns:
      setup = {
        -- this tells LazyVim “I handled Svelte setup; don’t do the default”
        svelte = function(_, opts)
          -- make sure the plugin is installed:
          -- `npm install -g svelte-language-server` or via your package manager
          require("lspconfig").svelte.setup(opts)
          -- if you want `.svelte` to use TS inference:
          vim.g.vim_svelte_plugin_use_typescript = 1
          return true
        end,
      },
    },
    diagnostics = {
      virtual_text = {
        severity = vim.diagnostic.severity.ERROR,
      },
      signs = {
        severity = vim.diagnostic.severity.ERROR,
      },
      underline = {
        severity = vim.diagnostic.severity.ERROR,
      },
    },
  }
}
