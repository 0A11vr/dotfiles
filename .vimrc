" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

Plug 'fehawen/sl.vim'
Plug 'preservim/nerdtree'

call plug#end()

syntax on
set magic
colorscheme bruin
set linebreak
set tabstop=4
set softtabstop=4
" set expandtab
set shiftwidth=4
set autoindent

" hide hidden chars
" :set nolist
" show hidden characters in Vim
:set list

" settings for hidden chars
" what particular chars they are displayed with
" stolen from https://gist.github.com/while0pass/511985
:set lcs=tab:▒░,trail:▓,nbsp:░
" \u2592\u2591 are used for tab, \u2593 for trailing spaces in line, and \u2591 for nbsp.
" In Vim help they suggest using ">-" for tab and "-" for trail.

" change showbreak when line numbers are on or off.
" show no char when line numbers are on, and \u21aa otherwise.
au OptionSet number :if v:option_new | set showbreak= |
                   \ else | set showbreak=↪ |
                   \ endif
