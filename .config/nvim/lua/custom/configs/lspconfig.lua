local plugins_lspconfig = require("plugins.configs.lspconfig")
local on_attach = plugins_lspconfig.on_attach
local capabilities = plugins_lspconfig.capabilities

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers = { "unocss", "emmet_ls", "bashls", "denols" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


-- lspconfig.pylint = {
--   default_config = {
--     cmd = { 'pylint' },
--     filetypes = { 'python' },
--     init_options = {
--       command = { 'pylint', 'run', '--output-format', 'json',  },
--       ignore={ "E501" },
--     },
--   },
-- }


lspconfig.pyright.setup {
  on_attach=on_attach,
  filetypes = {'python'},
  settings = {
    python = {
      autoSearchPaths = true,
      useLibraryCodeForTypes = true
    }
  }
}


lspconfig.omnisharp.setup {
  on_attach=on_attach,
  filetypes={'cs'},
  settings = {
  }
}
