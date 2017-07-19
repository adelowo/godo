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
		echohl Error | echo "Please install the astitodo library" | echohl None
		return -1
	endif

	if expand('%:e') ==# s:valid_ext
		let s:out = system("astitodo ". expand("%"))
	
		if s:out == ""
			echohl WarningMessage | echo "There are no todos in this file" | echohl None
			return 0
		endif

		botright new
		setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
		set nonumber

		let s:line_count = 0

		for line in split(s:out, '\n')
			let s:line_count = s:line_count + 1
			call setline(s:line_count, line)
		endfor

		setlocal nomodifiable
		return 0
	else
		echohl Error | echo "Godo works only with source code for the Go programming language" | echohl None
		return -1
	endif
	
endfunction

nnoremap <Leader>. :call Godo()<CR>
