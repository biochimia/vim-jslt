" Vim filetype plugin
" Language: JSLT
" Maintainer: João Abecasis <joao@abecasis.name>
" URL: https://github.com/schibsted/jslt
" Latest Revision: 5 May 2021

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

setlocal suffixesadd=.jslt
setlocal iskeyword=@,-,_,48-57,192-255
setlocal include="^\s*import\>"
setlocal comments=://
setlocal commentstring=//\ %s

" Script for filetype switching to undo the local stuff we may have changed
let b:undo_ftplugin = 'setlocal suffixesadd<'
  \ . '|setlocal iskeyword<'
  \ . '|setlocal include<'
  \ . '|setlocal comments<'
  \ . '|setlocal commentstring<'
  \ . '|unlet b:did_ftplugin'
