set nocompatible
filetype off

set encoding=utf-8
set fileencodings=utf-8

syntax on
set smartindent
set tabstop=2
set shiftwidth=2


nmap <\nt> :NERDTreeToggle<CR>
let g:NERDTreeNodeDelimiter = "\u00a0"

set nu


" 플러그인 설정
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

	" Plugin '플러그인 이름'
	Plugin 'scrooloose/nerdtree'
	Plugin 'kien/ctrlp.vim'


	" Vim-airline 설정 (하단 상태표시줄)
	Plugin 'vim-airline/vim-airline'
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#buffer_nr_show = 1
	let g:airline#extensions#tabline#buffer_nr_format = '%s'


	" vim-commentary 설정
	Plugin 'tpope/vim-commentary'
	nmap gc <Plug>Commentary
	vmap gc <Plug>Commentary


	" YouCompleteMe 설정 (auto complete)
	Plugin 'Valloric/YouCompleteMe'
	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
	let g:ycm_autoclose_preview_window_after_completion = 1
	let g:ycm_key_invoke_completion = '<c-space>'


	" ALE 설정 (auto lint)
	Plugin 'dense-analysis/ale'
	" JavaScript 파일에 대해 ESLint 사용
	" 모든 파일에 대해 기본적인 정리 작업 수행
	let g:ale_fixers = {
	\   'javascript': ['eslint'],
	\   'typescript': ['eslint'],
	\   '*': ['remove_trailing_lines', 'trim_whitespace']
	\}
	" 파일 저장 시 자동으로 수정 작업 실행
	let g:ale_fix_on_save = 1

call vundle#end()
filetype plugin indent on
