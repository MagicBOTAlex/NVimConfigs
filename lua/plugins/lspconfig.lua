return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "javascript",
        "typescript",
        "html",
        "css",
        "svelte",
        "c_sharp"
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      servers = {
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

        svelte = {
        },

        -- omnisharp = {
        --   -- Explicitly tell lspconfig to use the dotnet-driven assembly runner
        --   cmd = { "/home/botlap/.local/share/nvim/mason/bin/OmniSharp" },
        --   enable_roslyn_analyzers = true,
        --   organize_imports_on_format = true,
        --   enable_import_completion = true,
        -- },
        omnisharp = { enabled = false },

        -- 2. Disable csharp_ls so it doesn't clash with omnisharp
        csharp_ls = {
          enabled = false,
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

        clangd = {
          mason = false,
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--query-driver=**,/nix/store/*/bin/clang,/nix/store/*/bin/gcc",
            "--fallback-style=Google",
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("compile_commands.json", "platformio.ini", ".git")(fname)
          end,
        },

      },
      setup = {
        svelte = function(_, opts)
          require("lspconfig").svelte.setup(opts)
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
  },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      config = {
      },
    },
  },
  {
    "williamboman/mason.nvim",
    event = "UIEnter",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = true,
    opts = function(_, opts)
      opts.registries = opts.registries or {}
      table.insert(opts.registries, "github:Crashdummyy/mason-registry")
      table.insert(opts.registries, "github:mason-org/mason-registry")
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "bash-language-server",
          "css-lsp",
          "cpplint",
          -- "cpptools",
          "cssmodules-language-server",
          -- "elixir-ls",
          -- "emmet-language-server",
          -- "emmet-ls",
          "eslint-lsp",
          -- "html-lsp",
          "json-lsp",
          "lua-language-server",
          -- "pylsp",
          -- "ruff",
          -- "nextls",
          "basedpyright",
          "svelte-language-server",
          "prettier",
          "prisma-language-server",
          "rust-analyzer",
          "svelte-language-server",
          "tailwindcss-language-server",
          "typescript-language-server",
          "omnisharp",
          -- "nixfmt",
          "nixpkgs-fmt",
          "rnix-lsp",
          "golangci-lint",
        },
        auto_update = true,
      })
    end,
  },
}
