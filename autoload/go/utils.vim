
" GoPath returns the $GOPATH currently set. If the user does not have a
" $GOPATH, it makes use of the default $GOPATH which is available via `go env
" GOPATH`.
" Note that the default $GOPATH was introduced in Go 1.8
function! go#utils#GoPath()
	let l:path = $GOPATH

	if strlen(l:path) == 0
		return system("go env GOPATH")
	endif
	
	return l:path
endfunction
