
"nnoremap l l:vertical :resize +1<CR>
"nnoremap h h:vertical :resize -1<CR>
"
"nnoremap j <C-e>
"nnoremap k <C-y>k

set virtualedit=all

set nowrap

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
	let left_margin_width = window_width_cols/2 - virtcol(".")
	echo left_margin_width

	wincmd h
	:execute "vertical resize " .. left_margin_width
	wincmd l
	wincmd j
endfunction

function s:adjust_margins()
	call s:adjust_vertical_margins()
	call s:adjust_horizontal_margins()
endfunction

augroup VCenterCursor
	au!
	au BufEnter,WinEnter,WinNew,VimResized * let &scrolloff=winheight(win_getid())/2
	autocmd VimEnter * call s:prepare_centering_buffers()
	autocmd CursorMoved * call s:adjust_margins() 
augroup END



