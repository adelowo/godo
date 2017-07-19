command! GodoInstallBinary call s:GodoInstallBinary(-1)
command! GodoUpdateBinary call s:GodoInstallBinary(1)

let s:astitodo = "astitodo"

if !exists("g:godo_install_verbose")
	let g:godo_install_verbose = 0
endif

" go_get_update is actually a vim-go config value
" but we'd make use of that to avoid config bloat
" Virtually everyone uses vim-go, but we's still check if that is defined. If
" not, we turn it off.
if !exists("g:go_get_update")
	let g:go_get_update = 0
endif

" GodoInstallBinary installs or updates the binary for astitodo.
" It also checks if git and go are installed (just defensive stuffs anyways)
function! s:GodoInstallBinary(shouldUpdate)
	let err = s:CanInstallBinary()

	if err != 0
		return
	endif

	let l:cmd = "go get"

	if g:godo_install_verbose == 1
		let l:cmd .= " -v"
	endif

	if g:go_get_update == 1
		let l:cmd .= " -u"
	endif

	if !executable(s:astitodo) || a:shouldUpdate == 1
		if a:shouldUpdate == 1
			echo printf("godo : Updating %s", s:astitodo) 
		else
			echo printf("godo : Installing %s", s:astitodo)
		endif
	endif

	let l:out = system(l:cmd)

	if match(l:out, "exit status")
		echohl Error | echomsg printf("%s could not be installed.. An error occurred. ====  %s  ", s:astitodo, l:out) | echohl None
		return
	endif

	echohl Normal | echohl "Done.. You can now make use of godo" | echohl None

endfunction

" This are what are needed in other to install go tools
let s:bin_requirements = [
	\ "git",
	\ "go"
	\ ]

function! s:CanInstallBinary()
	for pkg in s:bin_requirements
		if !executable(pkg)
			let l:message = "godo : " . pkg . " not found. Please install " . pkg
			echohl Error | echomsg l:message | echohl None
			return -1
		endif
	endfor
endfunction

function! s:hasAstitido() 
	if executable('astitodo')
		return 0
	endif

	return -1
endfunction

function! Godo() 
	
	let s:valid_ext = "go"

	let err = s:hasAstitido()

	if err != 0 
		echohl Error | echomsg "Please install the astitodo library by running :GodoInstallBinary" | echohl None
		return -1
	endif

	if expand('%:e') ==# s:valid_ext
		let l:out = system("astitodo ". expand("%"))
	
		if l:out == ""
			echohl WarningMessage | echo "There are no todos in this file" | echohl None
			return 0
		endif

		botright new
		setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
		set nonumber

		let l:line_count = 0

		for line in split(l:out, '\n')
			let l:line_count = l:line_count + 1
			call setline(l:line_count, line)
		endfor

		setlocal nomodifiable
		return 0
	else
		echohl Error | echo "Godo works only with source code for the Go programming language" | echohl None
		return -1
	endif
	
endfunction

