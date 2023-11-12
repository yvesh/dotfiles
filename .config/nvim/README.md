# Neovim config

## Shortcuts

> A basic list of my Shortcuts. My <leader> key is as usually space (' ').

```
<leader>x -> Ex (Exit current file)
```

### Search 

```
<leader>p -> Open file search (fuzzy search with telescope) 
<leader>hp -> Open file search in home directory (fuzzy search with fzf)<leader>fz -> Open file search (fuzzy search with fzf) 
<leader>gs -> Grep search in files
<leader>vh -> Search for help / commands
<leader>ws -> Search for symbol
```

### LSP

```
<leader>f -> Format file with LSP
.... (mostly typical bindings, like K, gd see LSP help)
```

### Trouble

```
<leader>xq -> Quickfix
```


### Harpoon

> Save files for quick access

```
<leader>a -> Add file to short access list
Ctrl + e -> Show list of files
```

-----

### Other shortcuts, you should already now

> Not the really basic ones

```
Ctrl + o -> Previous file
Ctrl + i -> Next file

w -> Next word
b -> Previous word

Ctrl + w + v -> Split editor vertical (or vsp)
Ctrl + w + w -> Switch to other panes

gi -> Insert on last insert position
g, -> Jump to line with last editor

daw -> Cut word with space before (dw only deleted the word)
dap -> Cut whole paragraph
dib -> Cut next paranthesis
dit -> Cut tag content

```

### File Management

```
:e file -> Open / create file for editing
% -> New file (In file browser mode)
d -> New directory
```

