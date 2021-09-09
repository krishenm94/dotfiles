nnoremap <leader>ff <cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope resume<cr>
nnoremap <leader>fe <cmd>Telescope file_browser<cr>
nnoremap <leader>fs <cmd>lua require'telescope.builtin'.git_status()<cr>
