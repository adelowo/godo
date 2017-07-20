function! go#godo#Godo(...)

	let l:assignee = ""
	let s:valid_ext = "go"
	let err = go#utils#HasAstitodo()

	if a:0 == 1 && !empty(a:1)
		" Pick out the first args alone and see if todos need to be
		" filtered by an assignee
		" TODO(adelowo) Support multiple assignees ? :Godo a1 a2 a3 ?
		let l:assignee = a:1
	endif

	if err != 0 
		echohl Error | echomsg "Please install the astitodo library by running :GodoInstallBinary" | echohl None
		return -1
	endif

	if expand('%:e') ==# s:valid_ext

		let l:cmd = "astitodo"

		if !empty(l:assignee)
			let l:cmd .= " -a=".l:assignee.""
		endif

		let l:cmd .= " " . expand("%")

		let l:out = system(l:cmd)

		if l:out == ""
			let l:message = "There are no todos"

			" Properly format error messages for todo searches
			" with an assignee
			if !empty(l:assignee)
				let l:message .= " assigned to " . l:assignee
			endif

			echohl WarningMessage | echo l:message | echohl None
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

