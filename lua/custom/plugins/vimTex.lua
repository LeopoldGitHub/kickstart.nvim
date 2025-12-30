-- return {
--   'lervag/vimtex',
--   lazy = false, -- Do not lazy load!
--   init = function()
--     -- 1. Detect Operating System
--     local is_windows = vim.fn.has 'win32' == 1
--
--     -- 2. OS-Specific Viewer Configuration
--     if is_windows then
--       -- Windows settings (MiKTeX + SumatraPDF)
--       vim.g.vimtex_view_method = 'general'
--       vim.g.vimtex_view_general_viewer = 'SumatraPDF'
--       vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
--     else
--       -- Linux settings (TeX Live + Zathura)
--       vim.g.vimtex_view_method = 'zathura'
--     end
--
--     -- 3. Shared Compiler Settings (Works for both MiKTeX and TeX Live)
--     -- Both distributions include 'latexmk' which is what VimTeX uses by default
--     vim.g.vimtex_compiler_latexmk = {
--       options = {
--         '-shell-escape',
--         '-verbose',
--         '-file-line-error',
--         '-synctex=1',
--         '-interaction=nonstopmode',
--       },
--     }
--
--     -- 4. Optional: Fix for Windows shell (only if you experience issues with powershell/cmd)
--     if is_windows then
--       -- This helps VimTeX execute compiler commands correctly on Windows
--       vim.o.shell = 'cmd.exe'
--       vim.o.shellcmdflag = '/c'
--     end
--   end,
--
-- }
return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    local is_windows = vim.fn.has 'win32' == 1

    -- OS-Specific Viewer
    if is_windows then
      vim.g.vimtex_view_method = 'general'
      vim.g.vimtex_view_general_viewer = 'SumatraPDF'
      vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    else
      vim.g.vimtex_view_method = 'zathura'
    end

    -- Compiler Settings
    vim.g.vimtex_compiler_latexmk = {
      options = {
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }
    -- KEYMAPS
    --

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'tex',
      callback = function()
        vim.keymap.set('n', '<leader>lc', '<cmd>VimtexClean<cr>', {
          buffer = true, -- Crucial: only applies to the current LaTeX buffer
          desc = 'LaTeX: [C]leanup aux files',
        })
        local wk = require 'which-key'
        wk.add {
          { '<leader>l', group = '[L]aTeX', buffer = true },
          { '<leader>la', desc = 'Context [A]ctions', buffer = true },
          { '<leader>lc', desc = '[C]lean aux files', buffer = true },
          { '<leader>lC', desc = '[C]lean all (Full)', buffer = true },
          { '<leader>le', desc = 'Show [E]rrors', buffer = true },
          { '<leader>lg', desc = 'Show [G]raph/Status', buffer = true },
          { '<leader>lG', desc = 'Show [G]raph/Status (Full)', buffer = true },
          { '<leader>li', desc = 'VimTeX [I]nfo', buffer = true },
          { '<leader>lI', desc = 'VimTeX [I]nfo (Full)', buffer = true },
          { '<leader>lk', desc = '[K]ill/Stop Compile', buffer = true },
          { '<leader>lK', desc = '[K]ill/Stop all', buffer = true },
          { '<leader>ll', desc = 'Start [L]ive Compile', buffer = true },
          { '<leader>lL', desc = 'Compile [L]ine/Selected', buffer = true },
          { '<leader>lm', desc = 'Show [M]appings', buffer = true },
          { '<leader>lo', desc = 'Show [O]utput', buffer = true },
          { '<leader>lq', desc = 'Show [Q]uickfix', buffer = true },
          { '<leader>ls', desc = 'Toggle [S]tatus', buffer = true },
          { '<leader>lt', desc = 'Toggle [T]able of Contents', buffer = true },
          { '<leader>lT', desc = '[T]OC (Open Only)', buffer = true },
          { '<leader>lv', desc = '[V]iew PDF', buffer = true },
          { '<leader>lx', desc = 'Reload [X] (VimTeX)', buffer = true },
          { '<leader>lX', desc = 'Reload [X] State', buffer = true },
          { '<leader>lS', desc = '[S]ingle-shot Compile', buffer = true },
        }
        vim.api.nvim_create_autocmd('User', {
          pattern = 'VimtexEventCompileSuccess',
          callback = function()
            vim.cmd 'VimtexView'
          end,
        })
        vim.api.nvim_create_autocmd('BufUnload', {
          buffer = 0, -- Current buffer only
          callback = function()
            vim.cmd 'VimtexClean'
          end,
        })
      end,
    })
    -- Ensure VimTeX highlighting is always on
    vim.g.vimtex_syntax_enabled = 1
  end,
}
