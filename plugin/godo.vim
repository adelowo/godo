command! GodoInstallBinary call go#godo#GodoInstallBinary(-1)
command! GodoUpdateBinary call go#godo#GodoInstallBinary(1)

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


