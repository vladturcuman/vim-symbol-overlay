# Vim Symbol Overlay

Highlights symbols in different colours and allows jumping.

# Instalation 

You can use any vim pluging manager with the string "vladturcuman/vim-symbol-overlay".
For example:

 **vim-plug** &nbsp;` .vimrc  `
 ```vim
  Plug 'azabiong/vim-highlighter'
 ```

And binding keys:
` .vimrc  `
 ```vim
  set hlsearch!
  nnoremap * :SymbolOverlay<CR>
  cnoremap noh SymbolOverlayClear
 ```

