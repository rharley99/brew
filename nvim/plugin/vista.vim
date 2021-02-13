""" Vista
nnoremap <leader>va <cmd>Vista<CR>
let g:vista_sidebar_width = 40
let g:vista_echo_cursor = 0
let g:vista_default_executive = 'nvim_lsp'
let g:vista_icon_indent = ["* ", "-> "]
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "f",
\   "variable": "v",
\   "property": "p",
\   "constant": "c",
\   "method": "m",
\  }

autocmd BufEnter * if winnr("$") == 1 && vista#sidebar#IsOpen() | execute "normal! :q!\<CR>" | endif
