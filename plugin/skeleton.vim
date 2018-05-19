scriptencoding utf-8

" push user setting
let s:save_cpo = &cpo
set cpo&vim

let s:script_dir = expand('<sfile>:p:h:h')
autocmd BufNewFile *.html 0r s:script_dir . '/index.html'

" pop user setting
let &cpo = s:save_cpo
unlet s:save_cpo
