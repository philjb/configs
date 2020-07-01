syntax on
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set hlsearch
set ruler
set ignorecase
set smartcase
set wildmode=list:longest
set nocompatible
set laststatus=2
set statusline+=%F
set ttymouse=sgr
set spellfile=$HOME/.vim/spell/en.utf-8.add
exec 'silent mkspell! ' . &spellfile . '.spl'
autocmd BufRead,BufNewFile *.txt setlocal spell spelllang=en_us
autocmd BufRead,BufNewFile *.txt setlocal linebreak

if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

if &diff
    set cursorline
    map ] ]c
    map [ [c
    set mouse+=a
endif

" highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" strip trailing whitespace when saving a file
fun! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
" apply to all files
autocmd BufWritePre * :call StripTrailingWhitespaces()

