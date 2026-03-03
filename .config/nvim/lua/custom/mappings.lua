---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>y"] = { "+y", "copy to clipboard", opts = {} },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}


-- more keybinds!

return M
