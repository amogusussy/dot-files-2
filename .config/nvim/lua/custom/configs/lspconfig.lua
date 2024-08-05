local plugins_lspconfig = require("plugins.configs.lspconfig")
local on_attach = plugins_lspconfig.on_attach
local capabilities = plugins_lspconfig.capabilities

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers = { "unocss", "emmet_ls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


lspconfig.pylsp.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    filetypes = { 'py' },
  }
}

lspconfig.pylint = {
  default_config = {
    cmd = { 'pylint' },
    -- root_dir = nvim_lsp.util.root_pattern('.git', '__init__.py'),
    filetypes = { 'py' },
    init_options = {
      command = { 'pylint', 'run', '--output-format', 'json',  },
    },
  },
}
--
--
-- lspconfig.ast_grep.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {"c"},
-- }
