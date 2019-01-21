call pathogen#infect()
filetype plugin indent on
syntax on

let mapleader=","

set clipboard=unnamed  "osx clipboard compatibility

set expandtab         " enter spaces when tab is pressed
set tabstop=4         " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4      " number of spaces to use for auto indent
set smartindent       " copy indent from current line when starting a new line

set backspace=indent,eol,start " make backspaces more powerful
set nojoinspaces

set colorcolumn=80
set cursorline

set wildmode=longest,list
set incsearch
set hlsearch
set linebreak

set splitbelow
set splitright

set number relativenumber  " enable hybrid line numbering
set ls=2    " status bar at the bottom
set sc      " show partially completed commands
set mouse=a " allow mouse scroll
set noshowmode  " dont show -- INSERT --

set autoread
colorscheme desert

let g:lightline = {
\  'active': {
\    'left': [
\       ['mode', 'paste'],
\       ['gitbranch'],
\       ['filename']
\    ]
\  },
\  'subseparator': {
\    'left': ''
\  },
\  'component': {
\    'mode': '%{strpart(lightline#mode(), 0, 1)}',
\    'lineinfo': '↓%-3l→%-2v',
\  },
\  'component_function': {
\    'gitbranch': 'GitBranchStats',
\    'filename': 'LightlineFilename',
\    'fileformat': 'LightlineFileformat',
\    'filetype': 'LightlineFiletype'
\  }
\}

function! LightlineFileformat()
  return winwidth(0) > 85 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 85 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFilename()
  let filename = expand('%:f') !=# '' ? expand('%:f') : '[No Name]'
  let modified = &modified ? ' +' : ''
  let readonly = &readonly ? '  ⃠' : ''
  return filename . modified . readonly
endfunction

function! GitBranchStats()
    let branch = fugitive#head()
    if branch == ''
        return ''
    endif

    let changes = GitGutterGetHunkSummary()
    let change_val = or(changes[0] > 0 ? 4 : 0,
                   \    or(changes[1] > 0 ? 2 : 0,
                   \       changes[2] > 0 ? 1 : 0))

    let char_map = ['', ' -', ' ~', ' ≃', ' +', ' ±', ' +̃', ' ±̃']

    return 'ᚶ ' . branch . char_map[change_val]
endfunction

" backup in one directory, don't scatter stuff around
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

" remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" Close the quickfix and other windows with a q
nnoremap <expr> q (!&modifiable ? ':close!<CR>' : 'q')

"Custom tab widths for file types
autocmd Filetype html setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype sls setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype yml setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 sts=2 expandtab

set fillchars+=vert:\  " remove | char from split border

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

if executable('rg')
  " Use ripgrep over Grep
  set grepprg=rg\ --vimgrep
  set grepformat^=%f:%l:%c:%m
endif

if executable('fzf')
  "Fzf good for opening files
  nnoremap <leader>t :Files<cr>
  nnoremap <leader>b :Buffers<cr>
  nnoremap <leader>w :Windows<cr>
endif

command! -nargs=+ MyGrep execute 'silent grep! <args>' | copen | redraw!
nnoremap <leader>/ :MyGrep<space>

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" to swap windows A<>B: navigate to A, press bind, navigate to B, press bind
let g:windowswap_map_keys = 0 "prevent default bindings for windowswap plugin
nnoremap <c-w>y :call WindowSwap#EasyWindowSwap()<cr>
