-- Place this file in your ~/.config/nvim/lua/ directory (e.g., lua/meson_runner.lua)
-- In your init.lua, add: require('meson_runner')

local M = {}

-- CONFIGURATION
local keybind = '<leader>mr'
local split_direction = 'botright 15split'

local function compile_and_run()
  -- 0. Get the absolute path of the directory containing the current file
  local file_dir = vim.fn.expand '%:p:h'

  -- Guard: Check if meson.build exists in the file's directory
  -- This ensures it works even if you opened Neovim from a different folder
  if vim.fn.filereadable(file_dir .. '/meson.build') == 0 then
    vim.notify('No meson.build found in ' .. file_dir, vim.log.levels.WARN)
    return
  end

  -- 1. Save current buffer
  vim.cmd 'write'

  -- 2. Open the split AND create a fresh empty buffer
  vim.cmd(split_direction)
  vim.cmd 'enew'

  -- 3. Construct the shell command
  -- Added: 'cd' to the file's directory before running meson
  local cmd = 'cd '
    .. vim.fn.shellescape(file_dir)
    .. ' && '
    .. 'meson compile -C build && '
    .. "echo '\\n--- Compilation Success. Running Executable ---\\n' && "
    .. 'target=$(find ./build -maxdepth 1 -type f -executable '
    .. "! -name 'build.ninja' "
    .. "! -name '*.so' "
    .. "! -name '*.o' "
    .. '| head -n 1) && '
    .. '[ -n "$target" ] && $target || echo \'No executable found in ./build\''

  -- 4. Open the terminal
  vim.fn.termopen(cmd, {
    on_exit = function(job_id, code, event)
      if code == 0 then
        -- Optional: close window automatically on success?
        -- vim.cmd("close")
      end
    end,
  })

  -- 5. Terminal Cleanup
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = 'no'

  -- 6. Enter Insert mode
  vim.cmd 'startinsert'
end
local function compile()
  -- 0. Get the absolute path of the directory containing the current file
  local file_dir = vim.fn.expand '%:p:h'

  -- Guard: Check if meson.build exists in the file's directory
  -- This ensures it works even if you opened Neovim from a different folder
  if vim.fn.filereadable(file_dir .. '/meson.build') == 0 then
    vim.notify('No meson.build found in ' .. file_dir, vim.log.levels.WARN)
    return
  end

  -- 1. Save current buffer
  vim.cmd 'write'

  -- 2. Open the split AND create a fresh empty buffer
  vim.cmd(split_direction)
  vim.cmd 'enew'

  -- 3. Construct the shell command
  -- Added: 'cd' to the file's directory before running meson
  local cmd = 'cd ' .. vim.fn.shellescape(file_dir) .. ' && ' .. 'meson compile -C build && ' .. "echo '\\n--- Compilation Success. \\n'"

  -- 4. Open the terminal
  vim.fn.termopen(cmd, {
    on_exit = function(job_id, code, event)
      if code == 0 then
        -- Optional: close window automatically on success?
        -- vim.cmd("close")
      end
    end,
  })

  -- 5. Terminal Cleanup
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = 'no'

  -- 6. Enter Insert mode
  vim.cmd 'startinsert'
end

-- Create an autocommand to set the keybinding ONLY for C/C++ files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function(event)
    vim.keymap.set('n', keybind, compile_and_run, {
      buffer = event.buf,
      desc = 'Meson: Compile and Run',
      silent = true,
    })
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function(event)
    vim.keymap.set('n', '<leader>mc', compile, {
      buffer = event.buf,
      desc = 'Meson: Compile',
      silent = true,
    })
  end,
})
return M
