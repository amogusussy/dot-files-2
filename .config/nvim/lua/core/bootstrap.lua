local M = {}
local fn = vim.fn

M.echo = function(str)
  vim.cmd "redraw"
  vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

local function shell_call(args)
  local output = fn.system(args)
  assert(vim.v.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)
end

M.lazy = function(install_path)
  ------------- base46 ---------------
  local lazy_path = fn.stdpath "data" .. "/lazy/base46"

  M.echo "  Compiling base46 theme to bytecode ..."

  local base46_repo = "https://github.com/NvChad/base46"
  shell_call { "git", "clone", "--depth", "1", "-b", "v2.0", base46_repo, lazy_path }
  vim.opt.rtp:prepend(lazy_path)

  require("base46").compile()

  --------- lazy.nvim ---------------
  M.echo "  Installing lazy.nvim & plugins ..."
  local repo = "https://github.com/folke/lazy.nvim.git"
  shell_call { "git", "clone", "--filter=blob:none", "--branch=stable", repo, install_path }
  vim.opt.rtp:prepend(install_path)

  -- install plugins
  require "plugins"
  require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    multiwindow = false, -- Enable multiwindow support.
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20, -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
  }

  -- mason packages & show post_bootstrap screen
  require "nvchad.post_install"()
end

M.gen_chadrc_template = function()
  local path = fn.stdpath "config" .. "/lua/custom"

  if fn.isdirectory(path) ~= 1 then
    local input = fn.input "Do you want to install example custom config? (y/N): "

    if input:lower() == "y" then
      M.echo "Cloning example custom config repo..."
      shell_call { "git", "clone", "--depth", "1", "https://github.com/NvChad/example_config", path }
      fn.delete(path .. "/.git", "rf")
    else
      -- use very minimal chadrc
      fn.mkdir(path, "p")

      local file = io.open(path .. "/chadrc.lua", "w")
      if file then
        file:write "---@type ChadrcConfig\nlocal M = {}\n\nM.ui = { theme = 'onedark' }\n\nreturn M"
        file:close()
      end
    end
  end
end

return M
