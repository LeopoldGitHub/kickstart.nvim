local bufnr = vim.api.nvim_get_current_buf()
-- vim.keymap.set('n', '<leader>a', function()
--   vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
--   -- or vim.lsp.buf.codeAction() if you don't want grouping.
-- end, { silent = true, buffer = bufnr })
-- local bufnr = vim.api.nvim_get_current_buf()

-- Set F5 to trigger the rustaceanvim debuggables command
local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set('n', '<F5>', function()
  local dap = require 'dap'
  if dap.session() then
    dap.continue()
  else
    vim.cmd.RustLsp 'debuggables'
  end
end, { silent = true, buffer = bufnr, desc = 'Rust Debug/Continue' })
vim.keymap.set(
  'n',
  'K', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp { 'hover', 'actions' }
  end,
  { silent = true, buffer = bufnr }
)
