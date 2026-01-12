local themes = {
  'rebelot/kanagawa.nvim',
  'rose-pine/neovim',
  'folke/tokyonight.nvim',
  'ellisonleao/gruvbox.nvim',
  'EdenEast/nightfox.nvim',
  'navarasu/onedark.nvim',
  'Mofiqul/dracula.nvim',
}

local specs = {}
for _, theme in ipairs(themes) do
  table.insert(specs, { theme, lazy = true })
end

return specs
