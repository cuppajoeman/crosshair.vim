# crosshair.vim
A vim plugin that can center the cursor vertically and horizontally for a single file

# installation
Use your plugin manager of choice, if using vim-plug then just add `Plug 'cuppajoeman/crosshair.vim' into your vimrc.

# notice
This plugin is in it's early stages so please be patient as there may be some issues, in that direction PR's and issues are welcome.

It has only been tested on vanilla vim with quite basic `~/.vimrc`'s so I'm not sure how well it will play with other plugins at the moment.

## usage
With a full screen terminal, open a single file in vim and run `:Crosshair`, the cursor should now stay centered in the middle of the screen as you work on the file.

To leave the centered cursor mode, you have to save and quit and reload the file, use `:wqall` for this. In the future we will add a [command to toggle the mode](https://github.com/cuppajoeman/crosshair.vim/issues/3)

### working with multiple files

As of right now, working with multiple files can be done by starting to [edit](https://vimhelp.org/editing.txt.html#%3Aedit_f) a new file (`:e <file_name>`) to load a new file into the centered window, from there you can use [buffers](https://vimhelp.org/windows.txt.html#windows-intro) to switch back and forth between buffered files all while keeping the cursor centered
