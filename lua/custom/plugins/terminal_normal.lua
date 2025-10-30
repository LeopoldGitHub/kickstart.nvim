-- Your autocmd for new terminals (slightly improved)
-- This sets buffer-local options so it doesn't affect other windows
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    -- Set options local to the terminal buffer
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    -- Optional: Go directly into insert mode when terminal opens
    -- vim.cmd.startinsert()
  end,
})

-- This variable will hold the buffer number of our persistent terminal
-- It's 'local' to this config file and will persist as long as nvim is open
local persistent_term_bufnr = nil

vim.keymap.set('n', '<leader>tst', function()
  -- Check if our stored buffer number is valid (e.g., terminal hasn't been killed)
  if not (persistent_term_bufnr and vim.api.nvim_buf_is_valid(persistent_term_bufnr)) then
    -- 1. CREATE NEW TERMINAL (if it doesn't exist)
    -- Open a 10-line horizontal split at the bottom
    vim.cmd 'botright 10split'
    -- Start a new terminal
    vim.cmd.term()
    -- Store the buffer number of this new terminal
    persistent_term_bufnr = vim.api.nvim_get_current_buf()
    return -- Exit function, terminal is now open
  end

  -- If we're here, the buffer is valid. Now check if it's VISIBLE.
  -- vim.fn.bufwinid() returns a window ID if the buffer is visible, or -1 if not.
  local win_id = vim.fn.bufwinid(persistent_term_bufnr)

  if win_id ~= -1 then
    -- ---
    -- 2. CLOSE TERMINAL (if it's already visible)
    -- ---
    vim.api.nvim_win_close(win_id, false)
  else
    -- ---
    -- 3. OPEN EXISTING TERMINAL (if it's hidden)
    -- ---
    -- Open a 10-line horizontal split at the bottom
    vim.cmd 'botright 10split'
    -- Set the new window's buffer to our existing terminal buffer
    vim.api.nvim_set_current_buf(persistent_term_bufnr)
    -- The 'TermOpen' autocmd won't fire again, so we manually go to insert mode
    -- vim.cmd.startinsert()
  end
end, { desc = 'Toggle persistent bottom terminal' })

return {}
