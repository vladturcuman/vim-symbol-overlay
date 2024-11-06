" Title:        Vim Symbol Overlay
" Description:  Similar to emacs symbol overlay: highlights all symbols that 
" 		match the word under the cursor. Allows multiple highlighted
" 		symbols at the same time. Has a circular queue of highlighted 
" 		words. 
" Last Change:  2024-11-06
" Maintainer:   Vlad Turcuman

" if exists("g:loaded_vim_symbol_overlay")
"    finish
" endif
let g:loaded_vim_symbol_overlay = 1


command! -nargs=0 SymbolOverlay call vim_symbol_overlay#SymbolOverlay()
    
