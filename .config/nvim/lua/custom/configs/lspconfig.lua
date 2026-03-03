local plugins_lspconfig = require("plugins.configs.lspconfig")
local on_attach = plugins_lspconfig.on_attach
local servers = { "unocss", "emmet_ls", "bashls", "digestif", "ts_ls", "tinymist", "cssls", "hls", "clangd", "zls" }

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {})
  vim.lsp.enable({lsp})
end


vim.lsp.config("ts_ls", {
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
})

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
--

vim.lsp.config("pyright", {
  on_attach=on_attach,
  filetypes = {'python'},
  root_dir = function(fname)
    return vim.fn.getcwd()
        or require('lspconfig.util').find_git_ancestor(fname)
        or require('lspconfig.util').find_python_project_root(fname)
    end,
  settings = {
    python = {
      autoSearchPaths = true,
      useLibraryCodeForTypes = true,
      analysis = {
        extraPaths = {vim.fn.getcwd()},
      }
    }
  }
})
vim.lsp.enable({"pyright"})

vim.lsp.config("omnisharp", {
  filetypes={'cs'},
  settings = {
  }
})

vim.lsp.config("csharp_ls", {
  cmd = { "/home/matthew/.dotnet/tools/csharp-ls" },
  on_attach = function(client, bufnr)
    -- Safe semantic tokens start
    if client.server_capabilities.semanticTokensProvider then
      vim.lsp.semantic_tokens.start(bufnr, client.id)
    end
  end,
})


local lint = require("lint")

-- lint.linters.flake8.cmd = "flake8"
-- lint.linters.flake8.stdin = false
-- lint.linters.flake8.stream = "stdout"
-- lint.linters_by_ft = {
--   python = {
--     -- 'flake8',
--     'ruff'
--   },
-- }

-- lint.linters.ruff.args = {
--
-- }

lint.linters.pylint.cmd = "pylint"  -- or full path
lint.linters.pylint.args = {
  "-f", "json", "--score", "n"
}
lint.linters.pylint.stdin = false
lint.linters.pylint.stream = "stdout"

lint.linters_by_ft = {
  python = { "pylint" },
}

-- vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })
--
--
-- lspconfig.ruff.setup {
--   cmd = { "ruff", "server", "--preview" }, -- ensure ruff >=0.4.0
--   filetypes = { "python" },
--   root_dir = require("lspconfig.util").find_git_ancestor,
--   init_options = {
--     settings = {
--       args = {},
--     },
--   },
-- }

-- require'lspconfig'.tinymist.setup{
--   capabilities = vim.lsp.protocol.make_client_capabilities(),
--   flags = { debounce_text_changes = 150 },
--   settings = {
--     rust = {
--       semanticTokens = false,
--     },
--   },
-- }


vim.lsp.config("rust_analyzer", {
  filetypes = {'rust'},
})

vim.lsp.config("harper_ls", {
  filetypes = {
    "typst"
  },
  settings = {
    ["harper-ls"] = {
      userDictPath = "",
      workspaceDictPath = "",
      fileDictPath = "",
      linters = {
        SpellCheck = true,
        SpelledNumbers = true,
        AnA = true,
        SentenceCapitalization = true,
        UnclosedQuotes = true,
        WrongQuotes = true,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
        Matcher = true,
        CorrectNumberSuffix = true
      },
      diagnosticSeverity = "hint",
      isolateEnglish = false,
      dialect = "British",
      maxFileLength = 120000,
      ignoredLintsPath = {
      }
    }
  }

})
