## Godo - Browse todos in your Go source code


- [Introduction](#intro)
- [Features](#features)
- [Usage](#usage)

<div id="intro"> </div>

## Introduction

Godo is a plugin that allows you navigate through the todo messages in your Go project.

![Godo in action](https://github.com/adelowo/godo/blob/master/doc/screenshot.png)
It makes use of `astitodo` underneath.

<div id="features"> </div>

##  Feature
 - [x] Fast browsing of todos.
 - [ ] Todos
	- [x] View all todos in a specific file.
	- [ ] View todos in a file sorted by assignees.
	- [ ] Find all todos in the current folder opened.
 - [x] Show a nice warning message if there aren't any todo in the file.
 - [ ] Navigate to the source code line housing the todo message.
 - [x] Install `astitodo` binary by running `:GodoInstallBinary`.
 - [ ] Update `astitodo` binary by running `:GodoUpdateBinary`.


<div id="usage"> </div>

## Installation

I recommend you use [Vim-Plug](https://github.com/junegunn/vim-plug/blob/master/README.md) to manage your vim plugins.

With Vim-Plug installed, put the following lines in your vimrc:

```vim
Plug 'adelowo/godo', { 'do': ':GodoInstallBinary' }
```

Then execute `:PlugInstall` in command mode.

> `GodoInstallBinary` would fetch the astitodo binary used for matching/finding todos.

#### Configuration

```vim
" Config for :GodoInstallBinary and :GodoUpdateBinary
" This values defaults to 0

let g:go_get_update = 1 " Make use of the -u flag when installing the astitodo library.
let g:godo_install_verbose = 1 " Make use of the -v flag when installing the astitodo library..

" Refer to the official godoc for `go get` to understand what this flags stand for

```
> `g:go_get_update` is actually the same config defined by [`vim-go`](https://github.com/fatih/vim-go). If it doesn't exist, it is set to 0 anyways.

#### Todo Browsing

> godo doesn't come with key mapping defaults..

To view todos in a file, open the file buffer and `call Godo()` in command mode.. To map this to a key, you add this to your `init.vim` (`.vimrc`).

```vim

nnoremap <Leader>. :call go#godo#Godo()<CR>
```

#### License

MIT
