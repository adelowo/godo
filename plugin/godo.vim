command! GodoInstallBinary call s:GodoInstallBinary(-1)
command! GodoUpdateBinary call s:GodoInstallBinary(1)

function! s:GodoInstallBinary(shouldUpdate) abort
	let err = s:CanInstallBinary()

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

nnoremap <Leader>. :call Godo()<CR>
