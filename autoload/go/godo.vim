let s:astitodo = "astitodo"
let s:astitodo_repo = "github.com/asticode/go-astitodo/..."

function! go#godo#Godo(...)

	let l:assignees = ""
	let s:valid_ext = "go"

	if !go#utils#HasAstitodo()
		echohl Error | echomsg "Please install the astitodo library by running :GodoInstallBinary" | echohl None
		return -1
	endif

	if a:0 > 0
		let l:assignees = join(a:000, ",")
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

" Installs or updates the binary for astitodo.
" It also checks if git and go are installed (just defensive stuffs anyways)
function! go#godo#GodoInstallBinary(shouldUpdate)
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

	let l:cmd .= " ". s:astitodo_repo

	if a:shouldUpdate == 1
		echo printf("godo : Updating %s", s:astitodo)
	else
		echo printf("godo : Installing %s", s:astitodo)
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

