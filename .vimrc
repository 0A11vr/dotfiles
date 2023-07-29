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

Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
 Plug 'dhruvasagar/vim-table-mode'
Plug 'preservim/vim-markdown'


Plug 'lervag/vimtex'
call plug#end()

syntax on
set magic
"" colorscheme bruin
set linebreak

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4

set relativenumber number
se mouse+=a
set clipboard=unnamedplus

" hide hidden chars
" :set nolist
" show hidden characters in Vim
 :set list

" settings for hidden chars
" what particular chars they are displayed with
" stolen from https://gist.github.com/while0pass/511985
 :set lcs=tab:▒░,trail:▓,nbsp:░
" :set lcs=tab:>-,trail:-,nbsp:░
" \u2592\u2591 are used for tab, \u2593 for trailing spaces in line, and \u2591 for nbsp.
" In Vim help they suggest using ">-" for tab and "-" for trail.

" change showbreak when line numbers are on or off.
" show no char when line numbers are on, and \u21aa otherwise.
au OptionSet number :if v:option_new | set showbreak= |
                   \ else | set showbreak=↪ |
                   \ endif


" markdown-preview.nvim
let g:mkdp_auto_close=0
let g:mkdp_refresh_slow=0

"let g:mkdp_markdown_css=fnameescape($HOME).'/.config/Typora/themes/test.css'
"let g:mkdp_markdown_css=fnameescape($HOME).'/.config/Typora/themes/base.user.css'

"let g:mkdp_markdown_css=fnameescape($HOME).'/.config/Typora/themes/eloquent.css'
"
let g:mkdp_highlight_css = fnameescape($HOME).'/Templates/grayscale.css'



" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
 let g:vimtex_compiler_method = 'latexmk'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
""let maplocalleader = ","

let g:vimtex_quickfix_open_on_warning = 0

 let g:vimtex_compiler_latexmk_engines = 4

if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif



    let g:vimtex_compiler_latexmk_engines = {
        \ '_'                : '-lualatex',
        \ 'pdfdvi'           : '-pdfdvi',
        \ 'pdfps'            : '-pdfps',
        \ 'pdflatex'         : '-pdf',
        \ 'luatex'           : '-lualatex',
        \ 'lualatex'         : '-lualatex',
        \ 'xelatex'          : '-xelatex',
        \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
        \ 'context (luatex)' : '-pdf -pdflatex=context',
        \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
        \}


augroup VimCompletesMeTex
  autocmd!
  autocmd FileType tex
      \ let b:vcm_omni_pattern = g:vimtex#re#neocomplete
augroup END


" stolen from here: https://castel.dev/post/lecture-notes-1/
setlocal spell
set spelllang=en
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" disable folding for vim-markdown
let g:vim_markdown_folding_disabled = 1
" enable toc window auto-fit
let g:vim_markdown_toc_autofit = 1

" autosave for .adoc files
"autocmd TextChanged,TextChangedI <buffer> silent write
autocmd TextChanged,TextChangedI *.adoc silent write
