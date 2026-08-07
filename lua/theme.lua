local M = {}

local state_file = vim.fn.expand("$LOCALAPPDATA") .. "\\nvim\\theme-state"

local function read_state()
  local ok, lines = pcall(vim.fn.readfile, state_file)
  return (ok and lines[1]) or "dark"
end

function M.apply()
  vim.o.background = read_state()
end

function M.toggle()
  vim.fn.system('powershell -NoProfile -ExecutionPolicy Bypass -File "'
    .. vim.fn.expand("$APPDATA") .. '\\alacritty\\toggle-theme.ps1"')
  M.apply()
end

M.apply()
return M
