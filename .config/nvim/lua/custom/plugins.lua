local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        python = { "pylint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      -- {
      --   "jose-elias-alvarez/null-ls.nvim",
      --   config = function()
      --     require "custom.configs.null-ls"
      --   end,
      -- },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = "kevinhwang91/promise-async",
  --   config = function()
  --     require("custom.configs.ufo")
  --   end,
  -- }

  {
    "nvim-treesitter/nvim-treesitter-context"
  },
  {
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      require('symbol-usage').setup()
    end
  },
  -- {
  --   "EggbertFluffle/beepboop.nvim",
  --   opts = {
  --       audio_player = "mpv",
  --       max_sounds = 100,
  --       sound_directory = "/home/matthew/.config/nvim/lua/sounds",
  --       sound_map = {
  --           -- SOUND MAP DEFENITIONS HERE
  --           { key_map = { mode = "n", key_chord = "<leader>pv" }, sound = "chestopen.oga" },
  --           { key_map = { mode = "n", key_chord = "<C-Enter>" }, sound = "chestopen.oga" },
  --           { auto_command = "VimEnter", sound = "chestopen.oga" },
  --           { auto_command = "VimLeave", sound = "chestclosed.oga" },
  --           { auto_command = "InsertCharPre", sounds = {"stone1.oga", "stone2.oga", "stone3.oga", "stone4.oga"} },
  --           { auto_command = "TextYankPost", sounds = {"hit1.oga", "hit2.oga", "hit3.oga"} },
  --           { auto_command = "BufWrite", sounds = {"open_flip1.oga", "open_flip2.oga", "open_flip3.oga"} },
  --       }
  --   }
  -- },
  {
    "glepnir/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        lightbulb = { enable = false },
        diagnostic = {
          max_width = 80,
          max_height = 10,
        },
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
    end,
  },

  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --
  --  -- For `nvim-treesitter` users.
  --   priority = 49,
  --
  --   -- For blink.cmp's completion
  --   -- source
  --   -- dependencies = {
  --   --     "saghen/blink.cmp"
  --   -- },
  -- },
}

return plugins

