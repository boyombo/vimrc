" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"         for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"       for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

"vundle
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

"Let Vundle manage Vundle
"required!
"Bundle 'gmarik/vundle'

"My Bundles
"Bundle 'file:///Users/bayo/YouCompleteMe'

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  "Set to auto read when a file is changed from the outside
  set autoread

  "With a map leader it's possible to do extra key combinations
  "like <leader>w saves the current file
  let mapleader = ","
  let g:mapleader = ","

  "Fast saving
  nmap <leader>w :w!<cr>

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
set number
set bg=dark
set noic
set cursorline
set cursorcolumn
"fold settings
set foldmethod=indent "fold based on indent
set foldnestmax=10    "deepest fold is 10 levels
set nofoldenable      "don't fold by default
set foldlevel=1

if has("autocmd")
        autocmd FileType python set complete+=k/home/bayo/.vim/pydiction isk+=.,(
    endif " has("autocmd")
"minibuffer explorer configuration
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
"shortcuts for tasklist and taglist 
"map T :TaskList
"map Z :TlistToggle

autocmd FileType python set ft=python.django "For SnipMate
autocmd FileType html set ft=htmldjango.html "For SnipMate

"To save, ctrl-s,
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

"Don't like <c-r> for movement between viewports
nmap tt <c-w>

"bicyclerepair options
"let g:bike_exceptions = 1  "show tracebacks on exceptions
"let g:bike_progress = 1    "show import progress

"show invisible chars
set listchars=trail:.,tab:>~,nbsp:_
set list
"status line
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]
"set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\
"\ [%l/%L\ (%p%%)

"remap jj to escape in insert mode.
inoremap jj <ESC>

nnoremap JJJJ <Nop>

"remap ; to :
nnoremap ; :

"Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>n <esc>:tabprevious<cr>
map <leader>m <esc>:tabnext<cr>

"Quit all windows
noremap <leader>E :qa!<cr>

"Insert breakpoint
map <leader>b oimport ipdb;ipdb.set_trace()<esc>

" Improve up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" Clear search highlights
noremap <silent><leader>/ :nohls<cr>

" Easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

"Switch CWD to direcotory of open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

"Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal! g`\"" |
    \ endif
"Remember info about open buffers on close
set viminfo^=%

"Delete trailing white space on save, useful for Python and CoffeeScript
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
"For pathogen
execute pathogen#infect()
"For flake
"autocmd BufWritePost *.py call Flake8()
"let g:flake8_builtins="_,apply"

" User interface -----------

colorscheme elflord

" Behaviour ----------------

set splitbelow splitright " More intuitive than default split behaviour
set noswapfile            " No annoying swap files
set history=500           " keep 50 lines of command line history
set undolevels=500        " undo levels of 500
set ruler                 " show the cursor position all the time
set showcmd               " display incomplete commands
set showmatch             "show matching brackets when text indicator is over them

" Searching ----------------

set incsearch             " do incremental searching
set smartcase             " allow searching with lowercase
set ignorecase            " ignore case when searching

" Tabs and spaces ----------

set shiftwidth=4          " Spaces to use for each indent step
set shiftround            " Round intent to multiple of shiftwidth
set tabstop=4
set softtabstop=4         " Spaces to use for <tab> and <BS> editing
set expandtab             " Use appropriate num of spaces for <tab> in insert mode

" Better copy and paste
set pastetoggle=<F2>
set clipboard=unnamed
