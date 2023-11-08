" Vim global plugin keeping the cursor vertically and horizontally centered
" Last Change:	2023 Nov 7
" Maintainer:	cuppajoeman <ccn@cuppajoeman.com>
"
" very
" longgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg

if exists("g:loaded_crosshair")
	finish
endif
let g:loaded_crosshair = 1

let s:crosshair_active = 0

function s:set_custom_options()
	set virtualedit=all
	set nowrap
	let &scrolloff=winheight(win_getid())/2
	let &sidescrolloff=999
	"let &sidescrolloff=winwidth(win_getid())/2
endfunction

function s:prepare_centering_buffers()
	:vsplit left
	wincmd l
	:split
	:split top
	wincmd j
	wincmd j
	:split bottom
	wincmd j
	:q
	wincmd k
endfunction

function s:deconstruct_centering_buffers()
	" todo
	return 0
endfunction

command Setup call s:prepare_centering_buffers()

command Test call s:adjust_vertical_margins()

function s:get_size_of_top()
	" potential source of errors if there
	" is another buffer called left
	let window_height_cols = &lines
	" we need to subtract one
	let current_line_number = line(".")
	" subtract 1 because the statusbar of that buffer takes one line
	return max([0, window_height_cols/2 - current_line_number - 1])
endfunction

function s:get_size_of_bottom()
	let window_height_rows = &lines
	let lines_in_file = line("$")
	" subtract one because of status lien
	return max([0, window_height_rows/2 - lines_in_file + line(".") - 1])  
endfunction

function s:adjust_vertical_margins()
	:execute winnr('1k') .. "resize " ..  s:get_size_of_top()
	:execute winnr('1j') .. "resize " ..  s:get_size_of_bottom()
endfunction

function s:adjust_horizontal_margins()
	" TODO do without movement
	let window_width_cols = &columns
	let left_margin_width = max([0,window_width_cols/2 - virtcol(".")])

	wincmd h
	:execute "vertical resize " .. left_margin_width
	wincmd l
	wincmd j
endfunction

function s:adjust_margins()
	call s:adjust_vertical_margins()
	call s:adjust_horizontal_margins()
endfunction


function s:bind_vim_callbacks()
	augroup crosshair
		autocmd! 
		autocmd BufEnter,WinEnter,WinNew,VimResized * let &scrolloff=winheight(win_getid())/2
		autocmd CursorMoved,CursorMovedI * call s:adjust_margins() 
	augroup END
endfunction

function s:crosshair_enable()
	call s:set_custom_options()
	call s:prepare_centering_buffers()
	call s:bind_vim_callbacks()
	"call s:adjust_margins()
endfunction

function s:crosshair_disable()
	augroup crosshair
		autocmd! * <buffer>
	augroup END
endfunction


function crosshair#execute(bang)
	if a:bang
		call s:crosshair_disable()
		let s:crosshair_active = 0
	else
		if !s:crosshair_active
			call s:crosshair_enable()
			let s:crosshair_active = 1
		endif " already active, don't do anything
	endif
endfunction
