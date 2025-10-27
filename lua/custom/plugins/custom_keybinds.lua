return {
  vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>', { desc = 'goes to next quickfix' }),
  vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>', { desc = 'goes to prev quickfix' }),
  vim.keymap.set({ 'n', 't' }, '<leader>tt', '<cmd>Floatterminal<return>', { desc = 'opens a floating terminal' }),
}
