function! go#godo#Godo()
	let s:valid_ext = "go"
	let err = go#utils#HasAstitodo()
	
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
		echohl Error | echo "Godo works only with source code for the Go programming language. Open up a file and check this out" | echohl None
		return -1
	endif
	
endfunction

