


" GPL-3.0 License

" prevent the plugin from loading twice
if exists('g:loaded_HighStr') | finish | endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

" Utils {{{
function! hscmds#get_first_arg(...)
	return "".get(a:, 1, 1).""
endfunction
" }}}

" Test Availability {{{
function! hscmds#available_args_tool_highlight() abort
	return luaeval('require("high-str.utils.available_args.args_tool_highlight").available_commands()')
endfunction

function! hscmds#available_args_tool_rmhighlight() abort
	return luaeval('require("high-str.utils.available_args.args_rmtool_highlight").available_commands()')
endfunction
" }}}

" Tab Completion {{{
function! s:complete_args_tool_highlight(arg, line, pos) abort
	return join(hscmds#available_args_tool_highlight(), "\n")
endfunction

function! s:complete_args_tool_rmhighlight(arg, line, pos) abort
	return join(hscmds#available_args_tool_rmhighlight(), "\n")
endfunction
" }}}


" Interface {{{
command! -nargs=* -complete=custom,s:complete_args_tool_highlight HSHighlight call v:lua.require("high-str.main").main(0,hscmds#get_first_arg(<f-args>))
command! -nargs=* -complete=custom,s:complete_args_tool_rmhighlight HSRmHighlight call v:lua.require("high-str.main").main(1,hscmds#get_first_arg(<f-args>))
" }}}


let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

" set to true the var that controls the plugin's loading
let g:loaded_HighStr = 1

