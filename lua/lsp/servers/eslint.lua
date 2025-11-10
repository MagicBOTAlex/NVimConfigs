local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

lspconfig.eslint.setup({
  root_dir = util.root_pattern(
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
    "eslint.config.js",
    "package.json",
    ".git"
  ),
  settings = {
    workingDirectories = { { mode = "auto" } },
  },
})

