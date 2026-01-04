return {
  vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>', { desc = 'goes to next quickfix' }),
  vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>', { desc = 'goes to prev quickfix' }),
  vim.keymap.set({ 'n', 't' }, '<leader>tt', '<cmd>Floatterminal<return>', { desc = 'opens a floating terminal' }),
  vim.keymap.set('n', 'q', '<Nop>', { desc = 'Disable macro recording' }),
  vim.keymap.set('n', '<leader>xe', '<cmd>source %<CR>', { desc = 'Execute current file' }),
  vim.keymap.set('n', '<leader>xx', '<cmd>!chmod +x %<CR>', { desc = 'Make file [x]ecutable' }),
  -- vim.keymap.set({ 'n', 'v', 'V' }, 'y', '"ay', { noremap = true, desc = 'Yank into register "a"' }),
  -- vim.keymap.set({ 'n', 'v', 'V' }, 'p', '"ap', { noremap = true, desc = 'Paste from Yank Register "a"' }),
  -- vim.keymap.set({ 'n', 'v', 'V' }, 'P', '"aP', { noremap = true, desc = 'Paste from Yank Register "a"' }),
  -- vim.keymap.set({ 'n', 'v', 'V' }, 'd', '"bd', { noremap = true, desc = 'Delete into register "b"' }),
  -- vim.keymap.set('n', '<C-p>', '"bp', { noremap = true, desc = 'Paste from Delete Register "b"' }),
  -- vim.keymap.set('n', '<C-P>', '"bP', { noremap = true, desc = 'Paste from Delete Register "b"' }),
}
