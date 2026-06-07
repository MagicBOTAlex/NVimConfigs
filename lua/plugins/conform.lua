return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        tex = { "latexindent" },
        plaintex = { "latexindent" },
        bib = { "latexindent" },
      },
      formatters = {
        latexindent = {
          -- Instruct latexindent to clean up log files automatically and run silently
          prepend_args = { "-c", "build/", "-m" },
        },
      },
    },
  },
}
