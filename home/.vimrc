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
set guifont=Consolas:h10:cANSI
set helplang=En
set window=73
map <C-o> :browse confirm edit <Cr>
set guifont=Monospace\ 9

"""""""""""""""""""""""""""""""""""""
"External plugins / Syntax files
"""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.as setf actionscript

"Syntax higlighting rules
syntax enable
let g:sienna_style='dark'
color sienna
"Force syntax highlighting to work for the entire file
"Turn this off if things get too slow
syn sync fromstart
set nu

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
set guioptions+=b;

"Folding settings
let g:xml_syntax_folding = 1
set foldlevel=1
set foldnestmax=2

set autochdir

"Sets the clipboard buffer to the unnamed (default) buffer
set clipboard=unnamed

"""""""""""""""""""""""""""""
" BINDSBINDSBINDSBINDS
"""""""""""""""""""""""""""""

"Regular vim OK
vmap <C-Del> "*d
vmap <S-Del> "*d
vmap <C-Insert> "*y

"Tabs
map <C-t> :tabnew<Cr>
map <C-w> :tabclose<Cr>
map K :tabn<Enter>
map J :tabp<Enter>
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
:command! W w
:command! E e

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
inoremap [<CR>  [<CR>]<Esc>O<Tab>

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

command PP %!python -mjson.tool
nmap <c-space> :noh<cr>
