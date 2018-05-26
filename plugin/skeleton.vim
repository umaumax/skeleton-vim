if exists('g:loaded_skeleton')
	finish
endif
let g:loaded_skeleton = 1

let s:file_size = getfsize(expand(@%))
if s:file_size > 0
	finish
endif

" push user setting
let s:save_cpo = &cpo
set cpo&vim

" TODO: add ~/.vim/template
let s:template_dir = expand('<sfile>:p:h:h') . '/template/'

let s:template_map = {}
for s:file in skeleton#ls(s:template_dir)
	let s:ext = fnamemodify(s:file, ':e')
	if !has_key(s:template_map, s:ext)
		let s:template_map[s:ext] = []
	endif
	call add(s:template_map[s:ext], s:file)
endfor

let s:key = expand("%:e")
"for s:key in keys(s:template_map)
if has_key(s:template_map, s:key)
	let s:files = s:template_map[s:key]
	if len(s:files) == 1
		let s:file = s:files[0]
		execute "autocmd BufNewFile *." . s:key . " 0r " . s:template_dir . s:file
	else
		let s:index = skeleton#dialog("Please choose template file!", s:files)
		let s:file = s:files[s:index]
		execute "autocmd BufNewFile *." . s:key . " 0r " . s:template_dir . s:file
	endif
endif
"endfor

" pop user setting
let &cpo = s:save_cpo
unlet s:save_cpo
