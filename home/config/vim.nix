{ pkgs, ... }:

let
  iro = pkgs.vimUtils.buildVimPlugin {
    name = "iro";
    src = pkgs.fetchFromGitHub {
      owner = "doctorn";
      repo = "iro";
      rev = "855ab89fa59804cb664fc8435e17630cc2329366";
      sha256 = "156g2836w2fg4gl4jpijkvyyad7fl56y0ih7wxl0g5bpalc1nfgi";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      coc-nvim
      unite-vim
      vimfiler-vim
      vimproc-vim
      rust-vim
      indentLine
      vim-airline
      typescript-vim
      vim-nix
      agda-vim
      iro
    ];
    extraConfig = ''
      set exrc
      set secure

      syntax on
      set background=dark
      colorscheme iro

      set nocompatible
      set modelines=0

      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set expandtab

      set cursorline
      hi CursorLine cterm=bold guibg=#41454d

      set encoding=utf-8
      set scrolloff=3
      set autoindent
      set showmode
      set showcmd
      set hidden
      set wildmenu
      set wildmode=list:longest
      set visualbell
      set ttyfast
      set ruler
      set backspace=indent,eol,start
      set number
      set laststatus=2

      set termguicolors
 
      set conceallevel=0

      let mapleader = "/"

      nnoremap / /\v
      vnoremap / /\v
      set ignorecase
      set smartcase
      set gdefault
      set incsearch
      set showmatch
      set hlsearch
      nnoremap <leader><space> :noh<cr>
      nnoremap <tab> %
      vnoremap <tab> %

      nnoremap <up> <nop>
      nnoremap <down> <nop>
      nnoremap <left> <nop>
      nnoremap <right> <nop>
      inoremap <up> <nop>
      inoremap <down> <nop>
      inoremap <left> <nop>
      inoremap <right> <nop>
      nnoremap j gj
      nnoremap k gk

      nnoremap <C-f> :VimFilerExplorer<cr>

      augroup myvimrchooks
          au!
          autocmd bufwritepost .vimrc source ~/.vimrc
      augroup END

      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#nvimlsp#enabled = 0

      let g:vimfiler_as_default_explorer = 1
		  let g:vimfiler_ignore_pattern = ['^.*\.agdai', '^\.']

      set statusline+=%{coc#status()}

      set hidden

      set nobackup
      set nowritebackup

      set cmdheight=2

      set updatetime=300

      set shortmess+=c

      set signcolumn=yes

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

      xmap <leader>f  <Plug>(coc-format-selected)
      nmap <leader>f  <Plug>(coc-format-selected)

      augroup mygroup
        autocmd!
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
      augroup end

      xmap <leader>a  <Plug>(coc-codeaction-selected)
      nmap <leader>a  <Plug>(coc-codeaction-selected)

      nmap <leader>ac  <Plug>(coc-codeaction)
      nmap <leader>qf  <Plug>(coc-fix-current)

      nmap <silent> <TAB> <Plug>(coc-range-select)
      xmap <silent> <TAB> <Plug>(coc-range-select)
      xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

      command! -nargs=0 Format :call CocAction('format')

      command! -nargs=? Fold :call     CocAction('fold', <f-args>)

      command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

      set statusline^=%{coc#status()}%{get(b:,'coc_current_function',\'\')}

      nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
      nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
      nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
      nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
      nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
      nnoremap <silent> <space>j  :<C-u>CocNext<CR>
      nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
      nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

      autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
      autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

      autocmd BufNewFile,BufRead *.mmtn setlocal filetype=rust

      let maplocalleader = ","
      let g:agda_extraincpaths = ["${pkgs.agdaPackages.standard-library}/src/"]
    '';

    withPython = true;
    withPython3 = true;

    vimAlias = true;

    extraPythonPackages = (ps: with ps; [
      unidecode
      pynvim
    ]);

    extraPython3Packages = (ps: with ps; [
      pynvim
      unidecode
      black
      isort
    ]);
  };
}
