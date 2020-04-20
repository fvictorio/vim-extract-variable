if exists("g:loaded_extract_variable") || &cp
  finish
endif
let g:loaded_extract_variable = 1

function! s:ExtractToVariable(visual_mode)
  " Check if 'filetype' is set
  if &filetype == ''
    echo "'filetype' is not set"
    return
  endif

  " Check if language is supported
  let l:supported_languages = ['elixir', 'go', 'javascript', 'r', 'typescript', 'python', 'ruby']
  let l:filetype = split(&filetype, '\.')[0]

  if index(l:supported_languages, l:filetype) == -1
    echo l:filetype . ' is not supported. Please open an issue at https://github.com/fvictorio/vim-extract-variable/issues/new'
    return
  endif

  " Yank expression to z register
  let saved_z = @z
  if a:visual_mode ==# 'v'
    execute "normal! `<v`>\"zy"
  else
    execute "normal! vib\"zy"
  endif

  " Ask for variable name
  let varname = input('Variable name? ')

  if varname != ''
    execute "normal! `<v`>s".varname."\<esc>"

    if l:filetype ==# 'javascript' || l:filetype ==# 'typescript'
      execute "normal! Oconst ".varname." = ".@z."\<esc>"
    elseif l:filetype ==# 'go'
      execute "normal! O".varname." := ".@z."\<esc>"
    elseif l:filetype ==# 'elixir' || l:filetype ==# 'python' || l:filetype ==# 'ruby'
      execute "normal! O".varname." = ".@z."\<esc>"
    elseif l:filetype ==# 'r' 
      execute "normal! O".varname." <- ".@z."\<esc>"
    endif
  else
    redraw
    echo 'Empty variable name, doing nothing'
  endif

  let @z = saved_z
endfunction

nnoremap <leader>ev :call <sid>ExtractToVariable('')<cr>
vnoremap <leader>ev :<c-u>call <sid>ExtractToVariable(visualmode())<cr>
