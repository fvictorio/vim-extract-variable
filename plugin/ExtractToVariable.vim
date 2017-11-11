function! s:ExtractToVariable(visual_mode)
  let saved_z = @z
  if a:visual_mode ==# 'v'
    execute "normal! `<v`>\"zy"
  else
    execute "normal! vib\"zy"
  endif

  let varname = input('Variable name? ')
  if varname != ''
    execute "normal! `<v`>s".varname."\<esc>"

    let l:filetype = split(&filetype, '\.')[0]

    if l:filetype ==# 'javascript'
      execute "normal! Oconst ".varname." = ".@z."\<esc>"
    elseif l:filetype ==# 'go'
      execute "normal! O".varname." := ".@z."\<esc>"
    elseif l:filetype ==# 'python' || l:filetype ==# 'ruby'
      execute "normal! O".varname." = ".@z."\<esc>"
    endif
  else
    redraw
    echo 'Empty variable name, doing nothing'
  endif

  let @z = saved_z
endfunction

nnoremap <leader>ev :call <sid>ExtractToVariable('')<cr>
vnoremap <leader>ev :<c-u>call <sid>ExtractToVariable(visualmode())<cr>
