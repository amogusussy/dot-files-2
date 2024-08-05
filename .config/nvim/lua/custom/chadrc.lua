---@type ChadrcConfig
local M = {}

vim.opt.cursorline = true

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "tokyonight",
  theme_toggle = { "tokyonight", "one_light" },

  cmp = {
    icons = true,
    -- lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "darker_black", -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
  },

  statusline = {
    theme = "vscode_colored",
    separator_style = "default",
    overriden_modules = function(modules)
      table.insert(
        modules,
        #modules
      )
    end,
  },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
