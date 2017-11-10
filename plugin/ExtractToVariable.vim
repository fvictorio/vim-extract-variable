function! s:ExtractToVariable(visual_mode)
  if a:visual_mode ==# 'v'
    execute "normal! `<v`>\"zy"
  else
    execute "normal! viw\"zy"
  endif
  let varname = input('Variable name? ')
  execute "normal! `<v`>s".varname."\<esc>"
  execute "normal! Oconst ".varname." = ".@z."\<esc>"
endfunction

nnoremap <leader>ev :call <sid>ExtractToVariable()<cr>
vnoremap <leader>ev :<c-u>call <sid>ExtractToVariable(visualmode())<cr>
