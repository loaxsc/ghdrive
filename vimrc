let $VIMFILES = '~/.vim'
let $MYVIMRC = '~/.vim/vimrc'
let $PAGER=''

" vim-plug {{{
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'preservim/nerdcommenter'
"Plugin 'Valloric/YouCompleteMe'
Plug 'andymass/vim-matchup'
set rtp+=/home/loaxsc/.fzf/
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Color scheme
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'

" File/folder navigation
Plug 'preservim/nerdtree'
"Plug 'liuchengxu/vim-clap', {'do': ':Clap install-binary!' }
Plug 'liuchengxu/vista.vim'

" Initialize plugin system
call plug#end()
" }}}
" VIM OPTIONS {{{
" Not compatible to vi
set nocompatible
" Vim inside encoding
set encoding=utf-8

" Change Language
" useless, still chinese.
"language en_US.utf8
"language message en_US.utf8

filetype plugin indent on
syntax on
set confirm
set modeline " modelines=1

" keep 500 lines of command line history
set history=500

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
set backspace=indent,eol,start

set showmatch

" show the last line of too long line when wrapped.
set display=lastline

"Set to auto read when a file is changed from the outside
set autoread

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Use visual bell instead of beeping when doing something wrong
"set novisualbell
"set noerrorbells
"set novb t_vb=
" Do not redraw, when running macros.. lazyredraw

" Change CWD for current file
set autochdir

set hidden

"colorscheme ron
" set cursor shape
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"if exists('$TMUX')
    " solid underscore
    let &t_SI .= "\<Esc>[6 q"
    " solid block
    let &t_EI .= "\<Esc>[2 q"
    " 1 or 0 -> blinking block
    " 3 -> blinking underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
"endif
" use 256 colors in terminal
set term=xterm-256color

" Set what session save.
"set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize,slash,unix,resize

set lazyredraw

" Backspace and cursor keys wrap to
set whichwrap+=<,>

set incsearch
set hlsearch
set ignorecase

set tabstop=4
set softtabstop=4 " Delete 4 space when <DEL>
set shiftwidth=4
set smarttab
"set expandtab
set autoindent
set smartindent
"set number numberwidth=5
set nowrap wildmenu
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

set fileencodings=utf-8,ucs-bom,big5,gb18030,gb2312,gbk,chinese,latin1
set ambiwidth=double
set completeopt=menu,menuone

" }}}

" Vim has poor performance for long line highlight, when the line is long and syntax highlight is on,
" Vim response extremely slow. limit the syntax hight length to resolve this problem.
"set synmaxcol=200

" Don't show denote message when Vim boot.
"set shortmess=atl
"set im
" Backup and Swapfile Option{{{
"set backup
set backupext=.bak
set backupdir^=/home/loaxsc/.vimbackup
"set patchmode=.org

" Swapfile
"set directory^=/home/loaxsc/.vimbackup
" }}}

" Plugins Option: {{{
" Taglist {{{
	" Only display tags for current file.
	"let Tlist_Show_One_File = 1
	set tags+=~/Repository/ml/jupyter/ODbDL/chapter4/faster-rcnn.pytorch-pytorch-1.0/myctags
	let Tlist_Exit_OnlyWindow = 1
	let Tlist_File_Fold_Auto_Close = 1
" }}}
" autohotkey_SIDE {{{
	"let g:AhkSIDE_AhkExe = 'C:\AutoHotkey_LA.exe'
	"let g:AhkSIDE_AhkChm = 'D:\PortableApp\AutoHotkey\AutoHotkey_L\AutoHotkey_L.chm'
	"let tlist_autohotkey_settings = 'ahk;k:Hotkeys;s:Hotstrings;l:Labels;f:Functions'
" }}}
" NERDTree {{{
	let NERDTreeNodeDelimiter = "\u00a0"
	let NERDTreeDirArrowExpandable = 1
	let NERDTreeGlyphReadOnly = 1
	let NERDTreeDirArrowCollapsible = 1
    let NERDTreeIgnore=['\.\(org\|bak\)$', '\~$','\.goutputstream-......']
	let g:NERDTreeDirArrowExpandable = '▸'
	let g:NERDTreeDirArrowCollapsible = '▾'
"}}}
" NERD commenter {{{
	" Use compact syntax for prettified multi-line comments
	"let g:NERDCompactSexyComs = 1
	" Enable NERDCommenterToggle to check all selected lines is commented or not
	"let g:NERDToggleCheckAllLines = 1
" }}}
"}}}

" User Define Functions: {{{
    function! MyTabLine() "{{{
          let s = ''
          for i in range(tabpagenr('$'))

            " select the highlighting
            if i + 1 == tabpagenr()
			  "" winnr of tab
			  "let cntwin = winnr('$')
			  "if cntwin > 1
				  "let s .= '%#VimWarn#' . cntwin
			  "endif
              let s .= '%#TabLineSel#'
            else
              let s .= '%#TabLine#'
            endif

            " set the tab page number (for mouse clicks)
            let s .= '%' . (i + 1) . 'T'

            " the label is made by MyTabLabel()
            let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
          endfor

          " after the last tab fill with TabLineFill and reset tab page nr
          let s .= '%#TabLineFill#%T'

          " right-align the label to close the current tab page
          if tabpagenr('$') > 1
            let s .= '%=%#TabLine#%999X[x]'
          endif

          return s
	endfunction " }}}

    function! MyTabLabel(n) " {{{
        let buflist = tabpagebuflist(a:n)
        let winnr = tabpagewinnr(a:n)
        return split(bufname(buflist[winnr - 1]),'/')[-1]
	endfunction " }}}

	function! PreviewTag() " {{{
		let g:sb_org = &splitbelow
		let &splitbelow = 1
		exe "ptjump " . expand("<cword>")
		let &splitbelow = g:sb_org
	endfunction " }}}

" Switch to buffer according to file name
	function! SwitchToBuf(filename) " {{{
		"let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
		" find in current tab
		let bufwinnr = bufwinnr(a:filename)
		if bufwinnr != -1
			exec bufwinnr . "wincmd w"
			return
		else
			" find in each tab
			tabfirst
			let tab = 1
			while tab <= tabpagenr("$")
				let bufwinnr = bufwinnr(a:filename)
				if bufwinnr != -1
					exec "normal " . tab . "gt"
					exec bufwinnr . "wincmd w"
					return
				endif
				tabnext
				let tab = tab + 1
			endwhile
			" not exist, new tab
			exec "tabnew " . a:filename
		endif
	endfunction " }}}

" Freemind Data Generate
function! Tmp_Data_Wnd() " {{{
	" If buffer exists. {{{
	if bufexists('__tmp_data__')
		let bufnr_tmp_data = bufnr('__tmp_data__')

		" Switch to Tab contains __tmp_data__
		for i in range(1,tabpagenr('$'))
			for j in tabpagebuflist(i)
				if j == bufnr_tmp_data
					execute 'tabnext ' . i
					break
				endif
			endfor
		endfor

		" Switch to Window view to __tmp_data__
		if winbufnr(0) != bufnr_tmp_data
			execute bufnr_tmp_data . 'wincmd w'
		endif
	" }}}
	" If buffer not exists. {{{
	else
		tabedit +setlocal\ nobuflisted\ bt=nofile __tmp_data__
	endif " }}}
	0put*
endfunction " }}}
" }}}

" Commands: {{{
" Use-Define Command is a 'super' string replacement !

if !exists(":DiffOrig")
	" Convenient command to see the difference between the current buffer and the
	" file it was loaded from, thus the changes you made.
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis

	command -register MakeMacro let tmp = input('Make Macro in @<reg>: ',@<reg>)|
		  \ if strlen(tmp) | let @<reg> = tmp | endif |
		  \ unlet tmp

endif

	command! MYDIARY e ~/Dropbox/Data/AppFiles/Vim/Diary_2021/diary.markdown | normal Gzz
				   "\ set nonu wrap fdm=marker ft=diary | Voom
	command! WEIBO e /home/loaxsc/Dropbox/Data/AppFiles/Vim/Weibo
	command! MAN set nonu ts=8

	" :FMCode {{{
	" Use Richtext format of Freemind
	command! FMCode call FMCode()
	function! FMCode()
		%d
		let txt = substitute(@",'[[:space:]]\+$','','')
		let @" = "<html>\n" .
				\ "<head>\n" .
				\ "<style type=\"text/css\">\n" .
				\ "body { background: #FFFFFF; }\n" .
				\ "pre  { background: #F2F2F2; margin-left: 5px; margin-right: 5px; padding-left: 5px; padding-right: 5px; }\n" .
				\ "</style>\n" .
				\ "</head>\n" .
				\ "<body>\n<pre>\n" .
				\ txt . "\n" .
				\ "</pre>\n" .
				\ "</body>\n" .
				\ "</html>"
		put | 1d
	endfunction " }}}

	" :FMTable {{{
	" Use Plaintext format of Freemind
	command! FMTable call FMTable()
	function! FMTable()
		ec "Two-column or multi-column table ?\n" .
		 \ "  1. Two column\n" .
		 \ "  2. Muiltiple column\n"

		let choice = nr2char(getchar())
		if choice =~ '[12]'
			" To avoid 'press enter to continue'
			" It's useless to use 'silent' to avoid :s command message.

			" Remove empty line.
			silent %g/^\s*$/de

			" Remove space from line-start and line-end.
			%s/^\s\+\|\s\+$//ge

			" Make Table
			execute '%s/\s\+/\t/' . ( choice == '2' ? 'g' : '' )

			if getline(1) != '<table>'
				call append(0,'<table>')
			endif
			set list
		else
			ec 'Cancel'
		endif
	endfunction " }}}
" }}}

" Key Maps: {{{
"Set <leader>
"let mapleader = '\'

" Normal mode {{{
	nnoremap	<silent>	<F2>    :set hls!<BAR>set hls?<CR>
	nnoremap	<silent>	<S-F2>	:syntax sync fromstart<CR>
	" NERDTree toggle
	nnoremap	<F3>	:set nu!<CR>
	nnoremap	<F4>	:NERDTreeToggle<CR>
	nnoremap	<S-F4>	:TlistToggle<CR>
	nnoremap	<F8>	:up<BAR>!ghdrive-upload 'file update' '%'<CR>

	" Scroll
	nnoremap	gV		ggVG

	" Folder
	nnoremap	zJ		zjzt

	"  Move Cursor
	nnoremap	j	gj
	nnoremap	k	gk

	nnoremap	n	:set hls<CR>n
	nnoremap	N	:set hls<CR>N
	nnoremap	/	:set hls<CR>/
	nnoremap	?	:set hls<CR>?

	" clipboard/selection paste {{{
	nnoremap	gp		"+p
	nnoremap	gP		"+P
	nnoremap	gsp		"*p
	nnoremap	gsP		"*P
	nnoremap	<gp		"+p^
	nnoremap	<gP		"+P^
	nnoremap	<gsp	"*p^
	nnoremap	<gsP	"*P^
	" }}}
	" line edit {{{3
    " Add empty line
	nnoremap	<silent> <C-S-CR>	:call append(line('.'),"")<CR>j
    nnoremap	<silent> <S-CR>		:call append(line('.')-1,"")<CR>
    nnoremap			 <C-CR>		i<CR><C-[>
    " Move line
    nnoremap	<silent> <C-Down>	:m+<CR>
    nnoremap	<silent> <C-UP>		:m-2<CR>

	" Edit
	nnoremap	<S-Home>	v<Home><C-g>
	nnoremap	<S-End>		v<End>h<C-g>

	" Window cmd map {{{3
	nnoremap <c-h> <c-w>h
	nnoremap <c-l> <c-w>l
	nnoremap <c-j> <c-w>j
	nnoremap <c-k> <c-w>k
	" }}}
	" <leader> {{{
	nnoremap	<silent>		<leader>v		:e $MYVIMRC<CR>
    nnoremap	<silent>		<leader>r		:silent up<BAR>so %<CR>
    nnoremap	<silent>		<leader>s		:up<CR>
	nnoremap	<silent>		<leader>l		:set list!<CR>
    nnoremap	<silent>		<leader>=		:if &number<BAR>setl relativenumber<BAR>else<BAR>setl number<BAR>endif<BAR>ec<CR>
	" Wrap Line {{{
	nnoremap	<silent>		<Leader>w		:call ToggleWrap()<CR>
	" ToggleWrap() {{{
	if !exists('*ToggleWrap')
		function ToggleWrap()
		  if &wrap
			setlocal nowrap
			if exists('b:wrap')
				nunmap <buffer> j
				nunmap <buffer> k
				xunmap <buffer> j
				xunmap <buffer> k
			endif
		  else
			setlocal wrap
			nnoremap <buffer> j gj
			nnoremap <buffer> k gk
			xnoremap <buffer> j gj
			xnoremap <buffer> k gk
			if !exists('b:wrap')
				let b:wrap=1
			endif
		  endif
		endfunction
	endif " }}}
	" }}}
	" Zenburn {{{
    nnoremap	<silent>		<leader>z		:let g:zenburn_high_Contrast = !g:zenburn_high_Contrast<BAR>
												\ colorscheme zenburn<BAR>
												\ hi IncSearch guibg=plum1<CR>
	" }}}
	nnoremap	<silent>		<leader>d		:redraw!<CR>
	nnoremap	<silent> <expr>	<leader>g		&columns == 100 ? ":set columns=150\<CR>"
															 \ : ":set columns=100\<CR>"
	" }}}
" Misc. {{{
	nnoremap	<expr>		<Home>		col('.') > match(getline('.'),'\p') + 1 ? "^" : "0"

	" Run vim script.
    nnoremap	<silent>	<F12>	    :if !exists('b:VimScript') <BAR><BAR> strlen(b:VimScript) == 0 <Bar>
										\	let b:VimScript = browse(0,'Select Vim Script','','') <Bar>
										\endif <Bar>
										\if strlen(b:VimScript) <Bar>
										\	exe 'so ' . b:VimScript <Bar>
										\endif<CR>
    nnoremap	<silent>	<S-F12>	    :let b:VimScript = browse(0,'Select Vim Script','','')<CR>
" }}}
" }}}

" Insert mode {{{2
	inoremap <expr> <C-y>	pumvisible()
								\ ? "\<C-y>"
								\ : matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|\s\+\\|.\)')

	inoremap <expr> <C-e>	pumvisible()
								\ ? "\<C-e>"
								\ : matchstr(getline(line('.')+1), '\%' . virtcol('.') . 'v\%(\k\+\\|\s\+\\|.\)')

	inoremap <expr>	<Home>	col('.') > match(getline('.'),'\p') + 1
								\ ? "\<Esc>^i"
								\ : "\<C-o>0"


	"Moving fast to front, back and 2 sides
	inoremap		<m-4> <esc>$a
	inoremap		<m-6> <esc>^i
	inoremap		<m-0> <esc>0i

	" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
	" so that you can undo CTRL-U after inserting a line break.
	inoremap	<C-U>		<C-G>u<C-U>

	inoremap	<expr>	<C-l>	pumvisible() ? "\<C-l>"  : "\<Del>"
	inoremap	<expr>	<C-k>	pumvisible() ? "\<Up>"   : "\<C-k>"
	inoremap	<expr>	<C-j>	pumvisible() ? "\<Down>" : "\<C-j>"

	" Use NERDCommenter command, so inoremap won't work.
	imap		<kMinus>	<C-o><leader>c<Space>

	" Motion
	imap		<C-b>		<Home>
	"inoremap	<C-e>		<End>

	" Edit {{{
	" Unable to execute commands which change the text in buffer in funciton.
	" To generate key-sequences in imap <expr> mode.
	inoremap <expr>	<C-Del>		substitute(matchstr(getline('.') . ' ' . getline(line('.') + 1),'\S*\s*',col('.') - 1),'.',"\<DEL>",'g')
	inoremap <expr>	<S-ins>		strlen(@*) ? '<MiddleMouse>' : '<C-o>"+p'
	inoremap		<C-BS>		<C-w>

	" <S-Home> <S-End> {{{
	inoremap <expr>	<S-Home>	strlen(getline('.'))+1 == col('.')
									\ ? "\<Esc>v\<Home>\<C-g>"
									\ : "\<Esc>hv\<Home>\<C-g>"
	inoremap		<S-End>		<C-o>v<End>h<C-g>
	" }}}

	" Line edit
	inoremap		<C-Up>		<C-o>:m-2<CR>
	inoremap		<C-Down>	<C-o>:m+<CR>
	" }}} edit
	" }}}2 insert mode

" Visual mode {{{2
	vnoremap	i>	T>ot<
	vnoremap	i<	T>ot<
	" Move selected lines
	vnoremap    <expr>	<C-up>		mode() ==# 'V' ? ":m-2\<CR>gv"  : "V:m-2\<CR>gv"
	vnoremap	<expr>	<C-down>	mode() ==# 'V' ? ":m'>+\<CR>gv" : "V:m'>+\<CR>gv"

	"  Move Cursor
	vnoremap	j	gj
	vnoremap	k	gk

	" Copy to clipboard
	vnoremap	<C-c>	"*y

	" Search selected text
	vnoremap	<silent> <leader>f	y/<C-r>=escape(@", "\\/.*$^~[]")<CR><CR>
	vnoremap	<silent> <leader>F	y?<C-r>=escape(@", "\\/.*$^~[]")<CR><CR>
	" Visual Search {{{
	" From an idea by Michael Naumann
	vnoremap	<silent> *			:call VisualSearch('f')<CR>
	vnoremap	<silent> #			:call VisualSearch('b')<CR>
	function! VisualSearch(direction) range " {{{
	  let l:saved_reg = @"
	  execute "normal! vgvy"
	  let l:pattern = escape(@", '\\/.*$^~[]')
	  let l:pattern = substitute(l:pattern, "\n$", "", "")
	  if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	  else
		execute "normal /" . l:pattern . "^M"
	  endif
	  let @/ = l:pattern
	  let @" = l:saved_reg
	endfunction " }}}
	" }}}

	" xnoremap is 'Visual Mode Only'
	" snoremap is 'Select Mode Only'

	" <Up> <Down> <Left> <Right> cancel visual mode. {{{
	xnoremap	<Up>	<Esc>k
	xnoremap	<Down>	<Esc>j
	xnoremap	<Left>	<Esc>h
	xnoremap	<Right>	<Esc>l
	" }}}

	" '|' has special meaning in Ex-mode.
	" It need to use "\\|" or "\<BAR>" in map {rhs}.
	xnoremap	<silent>	Y		y:let @+ = substitute(@",'\s\+\n\@=\<BAR>[[:space:]]\+$','','g')<BAR>ec 'Copy To Clipboard'<CR>
	xnoremap	<silent>	D		d:let @+ = substitute(@",'\s\+\n\@=\<BAR>[[:space:]]\+$','','g')<BAR>ec 'Cut To Clipboard'<CR>
	xnoremap	<silent>	gzf		:<C-u>call Fold_Make('f')<CR>
	xnoremap	<silent>	gzF		:<C-u>call Fold_Make('F')<CR>
	" Make Foldmarker
	" if flag is 'F', comment the first line
	function! Fold_Make(flag) " {{{
		"Check Options {{{
		if &foldmethod != 'marker' && empty(&foldmarker)
			return ''
		endif " }}}

		" Initialize Variables {{{
		" Set cmts ( According to 'comments' ) {{{
		let cmts = ''
		for cmt in split(&comments,',')
			if split(cmt,':',1)[0] !~ '[smef]'
				let cmts = substitute(substitute(split(cmt,':',1)[1],'^\s*','',''),'\s*$','','')
				break
			endif
		endfor
		" }}}

		let fs = matchstr(&foldmarker,'^.*\ze,')
		let fe = matchstr(&foldmarker,',\zs.*$')
		let ls  = line("'<")
		let le  = line("'>")
		let lsc = getline(ls)
		let lec = getline(le)

		" Get Folded Lines {{{
		"let fl  = []
		"let cl  = line("'>")
		"let ble = line('$')
		"while cl <= ble
			"if foldclosedend(cl) != -1
				"let fl = add(fl,cl)
				"let cl = foldclosedend(cl) + 1
			"endif
			"let cl += 1
		"endwhile " }}}
		" }}}

	" white space string also mean 'empty'!
		" If start-line isn't empty. {{{
		if lsc =~ '\S'
		" Start line {{{
			" flag 'f', append the comment in the end. {{{
			if a:flag ==# 'f'
				if lsc =~ '^\s*' . cmts
					call setline(ls,substitute(lsc,'\s*$',' ' . fs,''))
				else
					call setline(ls,substitute(lsc,'\s*$',' ' . cmts . ' ','') . fs)
				endif " }}}
			" flag 'F', comment the first line. {{{
			else
				if matchstr(lsc,'\S') ==# cmts
					call setline(ls,substitute(lsc,'\s*$',' ','') . fs)
				else
					call setline(ls,matchstr(lsc,'^\s*') . cmts . ' ' . matchstr(lsc,'\s*\zs.*\ze\s*') . ' ' . fs)
				endif
			endif " }}}
		" }}}
		" End line {{{
			if lec =~ '^\s*' . cmts
				call setline(le,substitute(lec,'\s*$',' ' . fe,''))
			elseif lec =~ '\S'
				call setline(le,substitute(lec,'\s*$',' ' . cmts . ' ' . fe,''))
			else
				call setline(le,matchstr(lsc,'^\s*') . cmts . ' ' . fe)
			endif " }}}
		" }}}

		" If end-line isn't empty. {{{
		elseif lec =~ '\S'
			call setline(ls,matchstr(lec,'^\s*') . cmts . ' ' . fs)
			if lec =~ '^\s*' . cmts
				call setline(le,substitute(lec,'\s*$',' ' . fe,''))
			else
				call setline(le,substitute(lec,'\s*$',' ' . cmts . ' ' . fe,''))
			endif " }}}

		" Both start and end line are empty. {{{
		else
			call setline(ls,cmts . ' ' . fs)
			call setline(le,cmts . ' ' . fe)
		endif " }}}

		"if !empty(fl) " {{{
			"for i in fl
				"execute i . 'foldclose'
			"endfor
			"foldopen
		"endif " }}}
	endfunction " }}}

	" <leader> Map {{{
    xnoremap    <silent> <leader>y	y:call CopyToClipboard()<CR>
    function! CopyToClipboard() " {{{
		" inputlist() version {{{
		"let choice = inputlist(['do something and copy to clipboard:',
							  "\ '  1. remove line-start space.',
							  "\ '  2. make two-column table.',
							  "\ '  3. make multi-column table.']) " }}}

		echo "do something and copy to clipboard:\n" .
           \ "  1. remove line-start space.\n" .
		   \ "  2. remove line-start space and line end special char.\n" .
           \ "  3. make two-column table.\n" .
           \ "  4. make multi-column table.\n"
		let choice = nr2char(getchar())

		if choice !~ '[1234]'
			ec "Cancel"
			return ''
		endif

		" Remove the last empty line.
		" Remove white characters in line start and line end.
		let pat = ( &ft ==# 'help' ? '|\|\*\p\+\*\|' : '' )
					\ . '\s*[\r\n]\+$\|\s\+$\|^\s\+\|\n\@<=\s\+\|\s\+\n\@='
		let txt = substitute(@0,pat,'','g')

		if choice == '1'
			let @* = txt
		elseif choice == '2'
			let @* = substitute(txt,'^\s\+\|[[:space:]]\+$\|' .
								\   '\n\@<=\s\+\|\s\+\n\@=\|[;\s]\+\n\@=\|[;\s]\+$','','g')
		elseif choice == '3'
			let @* = substitute(txt,'\%(\n\S\+\)\@<=\s\+\|^\S\+\zs\s\+','\t','g')
		else
			let @* = substitute(txt,'\s\+','\t','g')
		endif
   endfunction  " }}}
   " }}}
" }}}

" Ex-mode {{{2
	cnoremap	<C-z>	<C-Left>
	cnoremap	<C-x>	<C-Right>
" }}}2 ex-mode
" }}}



" AutoCmds: {{{
augroup _vimrc
	au!
	" Disable highlight search when into insert mode. {{{
	au InsertEnter * if &hlsearch|let g:fgHLSearch = 1|set nohlsearch|endif
	au InsertLeave * if g:fgHLSearch|set hlsearch|let g:fgHLSearch = 0|endif

	" Create g:fgHLSearch
	let g:fgHLSearch = &hlsearch " }}}

	" Cmd Window
	au CmdwinEnter * map <buffer> <C-CR> <CR>q:

	" Before file writing
	" Remove white chars in line end and remove the content of line only with
	" white characters.
	" Use <C-o> to jump back.
	au BufWritePre * %s/\s\+$//e | nohlsearch
	"au BufWritePre */{page_with_pic,wm_pos}.info g/^\s*$/d
	"au BufWritePre * if &ft !~ 'markdown'|
					"\	%s/\s\+$//e|
					"\	%s/^\s\+$//e|
					"\	nohlsearch|
					"\ endif
	"au BufNewFile,BufRead *.js, *.html, *.css
	"\ set tabstop=2
	"\ set softtabstop=2
	"\ set shiftwidth=2
	" File Open
	" Jump to the last position last time leave.
	"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &ft !=# 'help' | exe "normal! g`\"" | endif

	" fcitx
	let g:fcitx_state = ''
	autocmd InsertLeave * let g:fcitx_state = system('fcitx-remote')[0] | call system('fcitx-remote -c')
	autocmd InsertEnter * if g:fcitx_state =~ '[02]' | call system('fcitx-remote -o') | endif

	" Change workdir automatically
	"set autochdir
	"autocmd BufWinEnter * if strlen(expand('%')) | cd %:h | endif
	"autocmd BufReadPost * if strlen(expand('%')) | cd %:h | endif
	"autocmd WinEnter * if strlen(expand('%')) | cd %:h | endif
	"autocmd TabEnter * if strlen(expand('%')) | cd %:h | endif

augroup END
" }}}

"set laststatus=2
"set t_Co=256
"let g:Powerline_symbols= "fancy"
" vim:fdm=marker noet ts=4 sw=4 tw=0
