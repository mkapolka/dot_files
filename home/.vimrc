"Pathogen
execute pathogen#infect()

"Gvim specific settings
version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0) <Cr>
let &cpo=s:cpo_save
unlet s:cpo_save
set background=dark
set helplang=En
set window=73
"Default <c-o> actually owns and this is useless?
"map <C-o> :browse confirm edit <Cr>

set guifont=ttyp014:h14

" Leader key (needs to come first because other binds need it to be so)
let mapleader = ","

"""""""""""""""""""""""""""""""""""""
"External plugins / Syntax files
"""""""""""""""""""""""""""""""""""""
"Flake8
"autocmd BufWritePost *.py call Flake8()
"let g:flake8_ignore="E501"

"Syntastic
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_always_populate_loc_list=1

command! CheckPy call SyntasticCheckPython()
function! SyntasticCheckPython()
    let old_checkers = g:syntastic_python_checkers
    let g:syntastic_python_checkers = ['flake8', 'pylint', 'python']
    SyntasticCheck
    let g:syntastic_python_checkers = old_checkers
endfunction

" Ctrl P
" Run at vim command line
" :helptags ~/.vim/bundle/ctrlp.vim/doc
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Highlighting options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au BufNewFile,BufRead *.as setf actionscript

"Syntax higlighting rules
syntax enable

"Sienna Options
let g:sienna_style='dark'
"Zenburn Options
let g:zenburn_high_Contrast=1
let g:zenburn_old_Visual=1

color zenburn
"Force syntax highlighting to work for the entire file
"Turn this off if things get too slow
syn sync fromstart
set nu

"Status lines and similar things
set ruler
set laststatus=2
set statusline=%<%f\ %h%m%r\ %y\ #%n%=%{v:register}\ %-14.(%l,%c%V%)\ %P
set showcmd

set hlsearch
"Indent handling
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
"smart indent not smart enough - management
"set smartindent 

set bs=indent,eol,start
set cpoptions+=I
set nowrap
" b = Bottom scroll bar
" c = Console prompt popups (great for OSX since you can't select options w/ keyboard)
set guioptions+=bc

"Folding settings
let g:xml_syntax_folding = 1
set foldlevel=1
set foldnestmax=2

"Split settings
set splitbelow
set splitright

set autochdir

"Sets the clipboard buffer to the unnamed (default) buffer
set clipboard="*

"""""""""""""""""""""""""""""
" BINDSBINDSBINDSBINDS
"""""""""""""""""""""""""""""

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Quickfix
nmap qfn :cn<cr>
nmap qfp :cp<cr>
nmap qfc :cc<cr>

"Regular vim OK
vmap <C-Del> "*d
vmap <S-Del> "*d
vmap <C-Insert> "*y

"Tabs
map <C-t> :tabnew<Cr>
map J gt
map K gT
"Little switcheroo inspired by help page (see :h Y)
map Y y$
"Windows style ctrl-backspace
imap <C-BS> <C-W>

"change [[ ]] etc to work less weird (i.e. not only work on the first column)
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

"Ben and Jerry's 'Fatfinger kludge'
command! W w
command! E e

"Shift-Delete and backspace work like expected
imap <S-Delete> <Esc>lcw
imap <S-Backspace> <Esc>cb

"Ctrl-S save bind
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

"Ctrl-N new bind
"nmap <C-n> :silent !gvim<Cr>

"set shell=C:\\cygwin\\bin\\mintty.exe
"set shellcmdflag=-

"Automatic Curly Block filling
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O<Tab>
inoremap {<S-CR>  {<CR>}<Esc>O<Tab>
inoremap {{     {{}}<Esc>hi
inoremap {}     {}

"Automatic square block filling
inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O<Tab>
inoremap [<S-CR>  [<CR>]<Esc>O<Tab>
inoremap [[     [[]]<Esc>hi
inoremap []     []

"Surround visually selected text in {}
"vnoremap <C-{> 

"Changes gf to open the highlighted file even if it doesn't exist yet
map gf :e <cfile><CR>

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

"inoremap <tab> <c-r>=Smart_TabComplete()<CR>

command! PP %!python -mjson.tool
command! PPX %!xmllint --format - 2>/dev/null
command! PPJ %!js-beautify.js -f -
nmap <c-space> :noh<cr>

command! Max call Maximize()

function! Maximize()
    set columns=999
    set lines=999
endfunction
