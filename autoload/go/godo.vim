function! go#godo#Godo(...)

	let l:assignees = ""
	let s:valid_ext = "go"
	let err = go#utils#HasAstitodo()

	if err != 0
		echohl Error | echomsg "Please install the astitodo library by running :GodoInstallBinary" | echohl None
		return -1
	endif

	if a:0 > 0
		let l:idx = 0
		while l:idx < a:0
			let l:assignees = l:assignees . "," . a:000[idx]
			let l:idx = l:idx + 1
		endwhile
	endif

	if expand('%:e') ==# s:valid_ext

		let l:cmd = "astitodo"

		if !empty(l:assignees)
			let l:cmd .= " -a=".l:assignees.""
		endif

		let l:cmd .= " " . expand("%")

		let l:out = system(l:cmd)

		if l:out == ""
			let l:message = "There are no todos"

			" Properly format error messages for todo searches
			" with an assignee
			if !empty(l:assignees)
				let l:message .= " assigned to " . l:assignees
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

