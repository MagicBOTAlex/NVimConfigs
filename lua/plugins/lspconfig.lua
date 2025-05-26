return {
  {
    "neovim/nvim-lspconfig",
    -- merge into LazyVim’s default LSP opts
    opts = {
      servers = {
        tailwindcss = {
          -- tell the Tailwind LSP how to find classes in Svelte files
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  -- matches `class="..."`, `class:active="..."`, etc.
                  { [[class[:]?%s*[:=]?%s*["'`]([^"'`}]*)["'`}]], 1 },
                },
              },
            },
          },
        },
      },
    },
  },
}
