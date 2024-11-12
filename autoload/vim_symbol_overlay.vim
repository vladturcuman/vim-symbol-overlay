
" defining colors
highlight SymbolOverlay0 ctermfg=black ctermbg=DarkBlue
highlight SymbolOverlay1 ctermfg=black ctermbg=DarkGreen
highlight SymbolOverlay2 ctermfg=black ctermbg=DarkRed
highlight SymbolOverlay3 ctermfg=black ctermbg=DarkCyan
highlight SymbolOverlay4 ctermfg=black ctermbg=DarkYellow
highlight SymbolOverlay5 ctermfg=black ctermbg=DarkMagenta
highlight SymbolOverlay6 ctermfg=black ctermbg=LightGreen
highlight SymbolOverlay7 ctermfg=black ctermbg=LightCyan
highlight SymbolOverlay8 ctermfg=black ctermbg=LightBlue

function! vim_symbol_overlay#MaybeInit()
	if !exists("b:symbol_hist") 
		let b:symbol_hist = []
		let b:unassigned_colors = [4, 0, 1, 2, 3, 5, 6, 7, 8]
		let b:symbol_to_color = {}
	endif
endfunction

function! vim_symbol_overlay#Highlight(symbol)
	let l:color_id = b:unassigned_colors[0]
	silent! call matchdelete(123 + l:color_id)
	call matchadd('SymbolOverlay'.l:color_id, '\<' . a:symbol . '\>', -1, 123 + l:color_id)
	let b:symbol_to_color[a:symbol] = l:color_id
	call filter(b:unassigned_colors, 'v:val !~ l:color_id')
	call add(b:symbol_hist, a:symbol)
	let @/ = '\<' . a:symbol . '\>'
	execute "normal! :nohlsearch<CR>"
endfunction

function! vim_symbol_overlay#RemoveHighlight(symbol)
	let l:color_id = b:symbol_to_color[a:symbol] 
	silent! call matchdelete(123 + l:color_id)
	unlet b:symbol_to_color[a:symbol]
	call filter(b:symbol_hist, 'v:val !~ a:symbol')
	call add(b:unassigned_colors, l:color_id)
	if @/ == '\<' . a:symbol . '\>'
		let @/ = ""
	endif
endfunction

function! vim_symbol_overlay#SymbolOverlay()
	let l:symbol = expand('<cword>')
	if l:symbol is# '' 
		return
        endif	       
	call vim_symbol_overlay#MaybeInit()
	if has_key(b:symbol_to_color, l:symbol)
		call vim_symbol_overlay#RemoveHighlight(l:symbol)
	else 	
		if len(b:unassigned_colors) == 0 
			call vim_symbol_overlay#RemoveHighlight(b:symbol_hist[0])
		endif
		call vim_symbol_overlay#Highlight(l:symbol)
	endif
endfunction

function! vim_symbol_overlay#Clear()
	call vim_symbol_overlay#MaybeInit()
	while len(b:symbol_hist) > 0
		call vim_symbol_overlay#RemoveHighlight(b:symbol_hist[0])
	endwhile
endfunction


