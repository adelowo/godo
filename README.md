## Godo - Browse todos in your Go source code

## Introduction

Godo is a plugin that allows you navigate  through the todo messages in your Go project.

It makes use of `astitodo` underneath.

##  Feature
 - [x] Fast browsing of todos.
 - [x] View all todos in a specific file.
 - [x] Show a nice warning message if there aren't any todo in the file.
 - [ ] Navigate to the source code line housing the todo message.


## Installation & Usage

I recommend you use [Vim-Plug](https://github.com/junegunn/vim-plug/blob/master/README.md) to manage your vim plugins.

With Vim-Plug installed, put the following lines in your vimrc:

```vim
Plug 'adelowo/godot'
```

Then execute `:PlugInstall` in command mode.


The default mapping for viewing todos is `<Leader>.`. If that is uncomfortable, you can edit it by doing something like 

```vim

nnoremap <Leader>go :call Godo()<CR>
```

#### License

MIT
