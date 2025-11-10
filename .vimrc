set ruler
set showmode
set listchars+=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

set number
set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch
"set nowrapscan
"set splitright
"set splitbelow

set scrolloff=2
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab

set fileformat=dos
set shortmess-=S "show search count
set cinoptions+=j1 "indent java anonymous classes

"let mapleader=","
"nnoremap <Leader>, ,

"https://github.com/morhetz/gruvbox
set background=dark 
autocmd vimenter * ++nested colorscheme gruvbox

"minpac https://github.com/k-takata/minpac
function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  call minpac#add('tpope/vim-sensible')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('justinmk/vim-sneak')
  call minpac#add('morhetz/gruvbox')
endfunction

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

function! PackList(...)
  call PackInit()
  return join(sort(keys(minpac#getpluglist())), "\n")
endfunction

command! -nargs=1 -complete=custom,PackList
      \ PackOpenDir call PackInit() | call term_start(&shell,
      \    {'cwd': minpac#getpluginfo(<q-args>).dir,
      \     'term_finish': 'close'})

