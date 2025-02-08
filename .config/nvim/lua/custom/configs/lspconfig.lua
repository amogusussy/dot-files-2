local plugins_lspconfig = require("plugins.configs.lspconfig")
local on_attach = plugins_lspconfig.on_attach
local capabilities = plugins_lspconfig.capabilities

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers = { "unocss", "emmet_ls", "bashls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


lspconfig.pylint = {
  default_config = {
    cmd = { 'pylint' },
    -- root_dir = nvim_lsp.util.root_pattern('.git', '__init__.py'),
    filetypes = { 'py' },
    init_options = {
      command = { 'pylint', 'run', '--output-format', 'json',  },
      ignore={ "E501" },
    },
  },
}


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


-- lspconfig.pylsp.setup {
--   on_attach=on_attach,
--   filetypes = {'python'},
--   settings = {
--   configurationSources = {"flake8"},
--   formatCommand = {"black"},
--   pylsp = {
--     plugins = {
--       jedi_completion = {
--         include_params = true,
--       },
--       jedi_signature_help = {enabled = true},
--       jedi = {
--         extra_paths = {'~/projects/work_odoo/odoo14', '~/projects/work_odoo/odoo14'},
--       },
--       pyflakes={enabled=true},
--       pylsp_mypy={enabled=false},
--       pycodestyle={
--         enabled=true,
--         ignore={'E501', 'E231'},
--         maxLineLength=120},
--         yapf={enabled=true}
--       }
--     }
--   }
-- }


lspconfig.omnisharp.setup {
  on_attach=on_attach,
  filetypes={'cs'},
  settings = {
  }
}
