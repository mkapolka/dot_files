filetype off

"Pathogen
execute pathogen#infect()
execute pathogen#helptags()

"filetype plugin indent on
filetype plugin on
syntax on

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

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Ttyp0
  elseif has("gui_macvim")
    set guifont=Ttyp014:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

" Leader key (needs to come first because other binds need it to be so)
let mapleader = "\\"

" Swapfile stuff
set dir=~/.vim/tmp/

"""""""""""""""""""""""""""""""""""""
"External plugins / Syntax files
"""""""""""""""""""""""""""""""""""""
"Syntastic
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1

command! CheckPy call SyntasticCheckPython()
function! SyntasticCheckPython()
    let old_checkers = g:syntastic_python_checkers
    let g:syntastic_python_checkers = ['flake8', 'pylint', 'python']
    SyntasticCheck
    let g:syntastic_python_checkers = old_checkers
endfunction

" Python-Mode
" Use syntastic instead
let g:pymode_lint=0
let g:pymode_run_bind = '<leader>R'
let g:pymode_doc_bind='<Leader>d'
let g:pymode_rope_complete_on_dot=0

set cot-=preview

" Ctrl P
" Run at vim command line
" :helptags ~/.vim/bundle/ctrlp.vim/doc
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'

augroup twee
	au! BufRead,BufNewFile *.tw   setfiletype twee 
    set makeprg=twee_make\ %
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Highlighting options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au BufNewFile,BufRead *.as setf actionscript

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
set guioptions+=c
"a: Autoselect
set guioptions-=a
"e: Gui tabs (ugly in xfce gvim)
set guioptions-=e
"m: Menu bar
set guioptions-=m
"T: Tool bar
set guioptions-=T

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

"Ignore .pyc files when expanding wildcards
set wildignore+=*.pyc

"""""""""""""""""""""""""""""
" BINDSBINDSBINDSBINDS
"""""""""""""""""""""""""""""

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Regular vim OK
vmap <C-Del> "*d
vmap <S-Del> "*d
vmap <C-Insert> "*y

inoremap <silent><C-backspace> <C-w>

"Tabs
map <C-t> :tabnew<Cr>
nnoremap J gt
nnoremap K gT
"Little switcheroo inspired by help page (see :h Y)
map Y y$

"Ben and Jerry's 'Fatfinger kludge'
command! W w
command! E e

"Ctrl-S save bind
nnoremap <silent><leader>s :w<CR>

"Automatic Curly Block filling
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O<Tab>
inoremap {<S-CR>  {<CR>}<Esc>O<Tab>
inoremap {{     {{}}<Esc>hi
inoremap {}     {}

"Automatic square block filling
inoremap [<CR>  [<CR>]<Esc>O<Tab>

function! NumberToggle()
    if(&relativenumber)
        set norelativenumber
        set number
    else
        set rnu
    endif
endfunction

nnoremap <silent><Leader>r :call NumberToggle()<CR>
vnoremap <silent><Leader>r :call NumberToggle()<CR>

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

nnoremap <silent><C-Space> :noh<cr>

"inoremap <tab> <c-r>=Smart_TabComplete()<CR>

command! PPX %!xmllint --format - 2>/dev/null
command! PPJ %!js-beautify -f -i

" Used on OSX because it's a shitty
command! Max call Maximize()

function! Maximize()
    set columns=999
    set lines=999
endfunction

" Make map
nnoremap <leader>m :mak!<cr>
