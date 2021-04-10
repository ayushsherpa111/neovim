set foldmethod=marker foldenable

filetype plugin indent on
syntax enable

set mouse=a
set ts=4 sw=4
set clipboard+=unnamedplus
set inccommand=split
set number
set noshowmode
set relativenumber
set termguicolors
set ignorecase
set smartcase
" Undo history
set undofile
set undodir=~/.config/nvim/undo

" Helper functions {{{
function! SetBackground()
      hi Normal guibg=NONE
      hi SignColumn guibg=NONE
      hi Folded guibg=NONE
endfunction

function! FileCmd()
      if system('git rev-parse --is-inside-work-tree') =~ 'true'
            :GFiles
      else
            :Files
      endif
endfunction
" }}}

" Remaps {{{
nnoremap <silent> <Esc> :nohlsearch<CR>
nnoremap <silent> <Space>f :call CocAction('format')<CR>
nnoremap <silent> <Space>e :CocCommand explorer<CR>
nnoremap <silent> <Space>q :CocFix<CR>
nnoremap <silent> <C-\> :call FileCmd()<CR>
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
nnoremap <silent> / :BLines<CR>
nnoremap <C-s> :%s/
" }}}

" Plugins {{{
call plug#begin(stdpath('data') . '/plugged')

" Utility
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
" Customization
Plug 'kaicataldo/material.vim'
Plug 'ntk148v/vim-horizon'
Plug 'itchyny/lightline.vim'
" Language specific
Plug 'sheerun/vim-polyglot'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

call plug#end()
" }}}

" Theme {{{
" The goal here is too keep background consistency
" so I make it transparent and set it in the term config

au! ColorScheme * call SetBackground()

let g:material_terminal_italics = 1
let g:material_theme_style = 'ocean'
colorscheme material

" Indent lines
let g:indentLine_color_term = 233
let g:indentLine_color_gui = '#3b3f51'

let g:indentLine_color_tty_light = 7
let g:indentLine_color_dark = 7

let g:indentLine_bgcolor_term = 202
" }}}

" Languages {{{
let g:python3_host_prog = '/usr/bin/python3'
let g:python_highlight_all = 1

" Fix for the indentLine extension
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

let g:livepreview_previewer = 'brave'


" File specific remaps for quick runs
augroup quick_run
      au!
      au FileType julia nnoremap <buffer> <Space>r :! julia %<CR>
      au FileType rust nnoremap <buffer> <Space>r :! cargo run<CR>
      au FileType python nnoremap <buffer> <Space>r :! python %<CR>
      au FileType csharp nnoremap <buffer> <Space>r :! dotnet run<CR>
      " I use Dart only for Flutter
      au FileType dart nnoremap <silent> <Space>r :CocCommand flutter.run<CR>
augroup END

" Preview
augroup preview
      au!
      au FileType markdown nnoremap <silent> <Space>p :MarkdownPreview<CR>
      au FileType tex nnoremap <silent> <Space>p :LLPStartPreview<CR>
augroup END
" }}}

" Lightline {{{
let g:lightline = {
      \ 'colorscheme': 'material_vim',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle
" }}}

