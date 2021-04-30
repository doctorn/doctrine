{ pkgs, ... }:

let
  iro = pkgs.vimUtils.buildVimPlugin {
    name = "iro";
    src = pkgs.fetchFromGitHub {
      owner = "doctorn";
      repo = "iro";
      rev = "4f23412e5b24550989a180746291d031a81ee073";
      sha256 = "ykxz4JOIaL3gtP0LcSwkngHyD6Kj6JPihgdcqsF0GwY=";
    };
  };
in
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-sensible

      vim-signify

      vim-fugitive
      vim-dispatch

      unite-vim
      vimproc-vim
      vimfiler-vim

      coc-nvim
      vim-nix
      rust-vim
      typescript-vim

      indentLine

      lightline-vim

      iro
    ];
    extraConfig = ''
      set exrc
      set secure
      set nocompatible
      set termguicolors
      set lazyredraw
      set noshowmode
      set showcmd
      set visualbell
      set ttyfast
      set hidden
      set number
      set wildmode=longest,list,full
      set undofile
      set report=0
      set nojoinspaces
      set signcolumn=yes
      set updatetime=500
      set nobackup
      set nowritebackup
      set shortmess+=cI

      syntax enable
      set background=dark
      colorscheme iro

      set cursorline
      hi CursorLine cterm=bold guibg=#41454d
      set scrolloff=3

      set encoding=utf-8
      set modeline modelines=1
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set expandtab
      set ignorecase
      set smartcase
      set conceallevel=0

      set gdefault
      set showmatch
      set hlsearch

      set list
      set listchars=nbsp:⦸
      set listchars+=trail:·
      set listchars+=tab:▸\ ,
      set listchars+=eol:¬
      set listchars+=extends:»
      set listchars+=precedes:«

      let mapleader = "/"
 
      nnoremap / /\v
      vnoremap / /\v
      nnoremap <leader><space> :noh<cr>
      nnoremap <tab> %
      vnoremap <tab> %

      nnoremap <C-f> :VimFilerExplorer<cr>
      let g:vimfiler_as_default_explorer = 1

      let g:lightline = {}
      let g:lightline.colorscheme = 'iro'

      augroup vimrc
          au!
          autocmd bufwritepost .vimrc source ~/.vimrc
      augroup END

      set statusline+=%{coc#status()}

      inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

      function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      inoremap <silent><expr> <c-space> coc#refresh()

      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

      nmap <silent> [c <Plug>(coc-diagnostic-prev)
      nmap <silent> ]c <Plug>(coc-diagnostic-next)

      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      nnoremap <silent> K :call <SID>show_documentation()<CR>

      function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
          execute 'h '.expand('<cword>')
        else
          call CocAction('doHover')
        endif
      endfunction

      autocmd CursorHold * silent call CocActionAsync('highlight')

      nmap <leader>rn <Plug>(coc-rename)

      xmap <leader>f <Plug>(coc-format-selected)
      nmap <leader>f <Plug>(coc-format-selected)

      augroup mygroup
        autocmd!
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
      augroup end

      xmap <leader>a <Plug>(coc-codeaction-selected)
      nmap <leader>a <Plug>(coc-codeaction-selected)

      nmap <leader>ac <Plug>(coc-codeaction)
      nmap <leader>qf <Plug>(coc-fix-current)

      nmap <silent> <TAB> <Plug>(coc-range-select)
      xmap <silent> <TAB> <Plug>(coc-range-select)
      xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

      command! -nargs=0 Format :call CocAction('format')

      command! -nargs=? Fold :call CocAction('fold', <f-args>)

      command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

      set statusline^=%{coc#status()}%{get(b:,'coc_current_function',\'\')}

      nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
      nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
      nnoremap <silent> <space>c :<C-u>CocList commands<cr>
      nnoremap <silent> <space>o :<C-u>CocList outline<cr>
      nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
      nnoremap <silent> <space>j :<C-u>CocNext<CR>
      nnoremap <silent> <space>k :<C-u>CocPrev<CR>
      nnoremap <silent> <space>p :<C-u>CocListResume<CR>

      autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
      autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

      autocmd BufNewFile,BufRead *.mmtn setlocal filetype=rust
    '';
  };
}
