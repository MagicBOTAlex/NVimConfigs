-- ~/.config/nvim/lua/lsp/servers/pylsp.lua
return {
  settings = {
    pylsp = {
      plugins = {
        -- disable rope altogether (so rope_rename won’t load)
        rope = { enabled = false },
        -- explicitly disable just the rename plugin
        rope_rename = { enabled = false },
      },
    },
  },
}

