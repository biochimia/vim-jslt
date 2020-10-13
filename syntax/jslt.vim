" Vim syntax file
" Language: JSLT
" Maintainer: João Abecasis <joao@abecasis.name>
" URL: https://github.com/schibsted/jslt
" Latest Revision: 12 October 2020

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn match   jsltStringEscape    +\\"\|\\\\+ contained
syn region  jsltString          start=+"+ skip=+\\\"\|\\\\+ end=+"+ contains=jsltStringEscape

syn match   jsltNumber          "\<-\?\%(0\|[1-9]\d*\)\%(\.\d\+\)\?\%([Ee][+-]\?\d\+\)\?\>"

syn keyword jsltConditional     if else
syn keyword jsltBoolean         true false
syn keyword jsltNull            null
syn keyword jsltRepeat          for
syn keyword jsltOperator        and or
syn match   jsltOperator        "\%(=\|==\|!=\|>=\|>\|<\|<=\|+\|-\|*\|\/\||\)"
syn match   jsltIdentifier      "\h\%(\w\|-\)*" display contained
syn keyword jsltStatement       let nextgroup=jsltIdentifier skipwhite
syn keyword jsltStatement       def nextgroup=jsltIdentifier skipwhite

syn keyword jsltImport          import nextgroup=jsltImportSource skipwhite
syn region  jsltImportSource    start=+"+ skip=+\\\"\|\\\\+ end=+"+ contains=jsltStringEscape nextgroup=jsltImportName skipwhite
syn keyword jsltImportName      as contained nextgroup=jsltIdentifier skipwhite

syn keyword jsltCommentTodo     FIXME NOTE TBD TODO XXX contained
syn match   jsltLineComment     "\/\/.*" contains=@Spell,jsltCommentTodo

" The default highlight links.  Can be overridden later.
hi def link jsltStatement       Statement
hi def link jsltImportSource    String
hi def link jsltImportName      Statement
hi def link jsltConditional     Conditional
hi def link jsltRepeat          Repeat
hi def link jsltOperator        Operator
hi def link jsltImport          Include
hi def link jsltIdentifier      Function
hi def link jsltLineComment     Comment
hi def link jsltCommentTodo     Todo
hi def link jsltNull            Constant
hi def link jsltBoolean         Boolean
hi def link jsltString          String
hi def link jsltStringEscape    Special
hi def link jsltNumber          Number

let b:current_syntax = "jslt"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set shiftwidth=2 softtabstop=2 tabstop=2 expandtab:
