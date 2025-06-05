local plugins_lspconfig = require("plugins.configs.lspconfig")
local on_attach = plugins_lspconfig.on_attach
local capabilities = plugins_lspconfig.capabilities

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers = { "unocss", "emmet_ls", "bashls", "digestif", "ts_ls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


lspconfig.ts_ls = {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = {"javascript", "typescript", "vue"},
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
}

lspconfig.pylint = {
  default_config = {
    cmd = { 'pylint' },
    filetypes = { 'python' },
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


lspconfig.omnisharp.setup {
  on_attach=on_attach,
  filetypes={'cs'},
  settings = {
  }
}


lspconfig.csharp_ls.setup({
  cmd = { "/home/matthew/.dotnet/tools/csharp-ls" },
  on_attach = function(client, bufnr)
    -- Safe semantic tokens start
    if client.server_capabilities.semanticTokensProvider then
      vim.lsp.semantic_tokens.start(bufnr, client.id)
    end
  end,
})
