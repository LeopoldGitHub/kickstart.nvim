return {},
  vim.keymap.set('n', '<leader>gv', vim.cmd.Ex, { desc = 'opens the file explorer' }),
  -- move line(s) up or down
  vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line/s down' }),
  vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line/s up' }),
  -- search and replace word under curser
  vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'search and replace word' })
