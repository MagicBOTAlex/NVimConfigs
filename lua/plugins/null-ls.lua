return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")

    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.formatting.prettier.with({
        filetypes = { "svelte", "javascript", "typescript", "css", "html", "json" },
      }),
    })
  end,
}
