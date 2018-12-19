call pathogen#infect()
filetype plugin indent on
syntax on

set expandtab           " enter spaces when tab is pressed
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set smartindent          " copy indent from current line when starting a new line

set backspace=indent,eol,start " make backspaces more powerful

set ruler   " show line and column number

set wildmenu " show autocomplete options
set wildmode=list:longest,full

set number  " line numbers
set ls=2    " status bar at the bottom
set sc      " show partially completed commands
set mouse=a " allow mouse scroll
set noshowmode
colorscheme desert 

" backup in one directory, don't scatter stuff around
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

"Custom tab widths for file types
autocmd Filetype html setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype sls setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype yml setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 sts=2 expandtab

set fillchars+=vert:\  " remove | char from split border, note significant whitespace 

" rebind panel selection to ctrl-{hjkl}
nnoremap <silent> <c-h> :wincmd h<cr>
nnoremap <silent> <c-j> :wincmd j<cr>
nnoremap <silent> <c-k> :wincmd k<cr>
nnoremap <silent> <c-l> :wincmd l<cr>

" rebind focus last panel to ctrl-p
nnoremap <silent> <c-p> :wincmd p<cr>

" rebind move window to ctrl-w + {hjkl}
nnoremap <silent> <c-w>h :wincmd H<cr>
nnoremap <silent> <c-w>j :wincmd J<cr>
nnoremap <silent> <c-w>k :wincmd K<cr>
nnoremap <silent> <c-w>l :wincmd L<cr>
