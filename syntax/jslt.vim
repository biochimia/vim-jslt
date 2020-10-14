" Vim syntax file
" Language: JSLT
" Maintainer: João Abecasis <joao@abecasis.name>
" URL: https://github.com/schibsted/jslt
" Latest Revision: 13 October 2020

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case match
syn iskeyword @,$,-,_,48-57,192-255

syn cluster jsltTop contains=jsltComment,jsltImport,jsltFunction,jsltLet,@jsltExpression
syn cluster jsltExpression contains=jsltComment,jsltParens,jsltArray,jsltObject,@jsltValue,@jsltReference,jsltFunctionCall,jsltIf,jsltElse,@jsltOperator,jsltErrMismatchPunct
syn cluster jsltChainLink contains=jsltDotKey,jsltArraySlice
syn cluster jsltReference contains=jsltVarReference,jsltDot,jsltDotKey
syn cluster jsltValue contains=jsltNull,jsltBoolean,jsltNumber,jsltString
syn cluster jsltOperator contains=jsltAssignOp,jsltCompareOp,jsltArithmeticOp,jsltLogicalOp,jsltColonOp,jsltPipeOp,jsltIf

syn match   jsltErrMismatchPunct            /[$).\]}]/

syn match   jsltComma             contained ','

syn keyword jsltImport                      import nextgroup=jsltImportSource,jsltErrExpectQuote skipwhite skipempty
syn region  jsltImportSource      contained matchgroup=jsltString start=/"/ skip=/\\"\|\\\\/ end=/"/ contains=jsltStringEscape nextgroup=jsltImportAs,jsltErrExpectAs skipwhite skipempty
syn keyword jsltImportAs          contained as nextgroup=jsltIdentifier,jsltErrBadIdentifier skipwhite skipempty

syn keyword jsltFunction                    def nextgroup=jsltFnIdentifier,jsltErrBadIdentifier skipwhite skipempty
syn match   jsltFnIdentifier      contained /\%(\w\|-\)\+/ nextgroup=jsltFnParams,jsltErrExpectParens skipwhite skipempty
syn region  jsltFnParams          contained matchgroup=_jsltFnParams start=/(/ end=/)/ contains=jsltIdentifierList,jsltErrBadIdentifier nextgroup=jsltLet,@jsltExpression,jsltErrExpectExpr skipwhite skipempty

syn keyword jsltLet                         let nextgroup=jsltLetIdentifier,jsltErrBadIdentifier skipwhite skipempty
syn match   jsltLetIdentifier     contained "\%(\w\|-\)\+" nextgroup=jsltAssignOp,jsltErrExpectAssign skipwhite skipempty

syn region  jsltParens                      matchgroup=_jsltParens start=/(/ end=/)/ contains=@jsltExpression
syn match   jsltIdentifier        contained /\%(\w\|-\)\+/

syn match   jsltIdentifierList    contained /\%(\w\|-\)\+/ nextgroup=jsltIdentifierComma,jsltErrExpectComma skipwhite skipempty
syn match   jsltIdentifierComma   contained /,/ nextgroup=jsltIdentifierList,jsltErrBadIdentifier skipwhite skipempty

syn match   jsltFunctionCall                /\%(\w\|-\)\+\%(:\%(\w\|-\)\+\)\?/ nextgroup=jsltFnArgs skipwhite skipempty
syn region  jsltFnArgs            contained matchgroup=_jsltFnArgs start=/(/ end=/)/ contains=jsltComma,@jsltExpression nextgroup=@jsltChainLink,@jsltExpression skipwhite skipempty

syn keyword jsltIf                          if nextgroup=jsltIfCondition,jsltErrExpectParens skipwhite skipempty
syn region  jsltIfCondition       contained matchgroup=_jsltIfCondition start=/(/ end=/)/ contains=jsltLet,@jsltExpression,jsltErrExpectExpr nextgroup=jsltLet,@jsltExpression,jsltErrExpectExpr skipwhite skipempty
syn keyword jsltElse                        else nextgroup=jsltLet,@jsltExpression,jsltErrExpectExpr skipwhite skipempty

syn region  jsltArray                       matchgroup=_jsltArray start=/\[/ end=/\]/ contains=jsltComma,@jsltExpression,jsltArrayFor skipwhite skipempty
syn keyword jsltArrayFor          contained for nextgroup=jsltArrayLoopCond,jsltErrExpectParens skipwhite skipempty
syn region  jsltArrayLoopCond     contained matchgroup=_jsltArrayLoopCond start=/(/ end=/)/ contains=@jsltExpression nextgroup=jsltLet,@jsltExpression,jsltErrExpectExpr skipwhite skipempty

syn region  jsltArraySlice        contained matchgroup=_jsltArraySlice start=/\[/ end=/\]/ contains=@jsltExpression nextgroup=@jsltChainLink,@jsltOperator skipwhite skipempty

syn region  jsltObject                      matchgroup=_jsltObject start=/{/ end=/}/ contains=jsltComma,jsltLet,@jsltExpression,jsltObjectFor skipwhite skipempty
syn keyword jsltObjectFor         contained for nextgroup=jsltObjectLoopCond,jsltErrExpectParens skipwhite skipempty
syn region  jsltObjectLoopCond    contained matchgroup=_jsltObjectLoopCond start=/(/ end=/)/ contains=@jsltExpression nextgroup=jsltLet,@jsltExpression,jsltErrExpectExpr skipwhite skipempty

syn match   jsltAssignOp          contained /=/ nextgroup=@jsltExpression,jsltErrExpectExpr skipwhite skipempty
syn match   jsltCompareOp         contained /\%(!=\|<\|<=\|==\|>\|>=\)/ nextgroup=@jsltExpression,jsltErrExpectExpr skipwhite skipempty
syn match   jsltArithmeticOp      contained /\%(+\|-\|*\|\/\)/ nextgroup=@jsltExpression,jsltErrExpectExpr skipwhite skipempty
syn match   jsltColonOp           contained /:/ nextgroup=@jsltExpression,jsltErrExpectExpr skipwhite skipempty
syn match   jsltPipeOp            contained /|/ nextgroup=@jsltExpression,jsltErrExpectExpr skipwhite skipempty
syn keyword jsltLogicalOp         contained and or nextgroup=@jsltExpression,jsltErrExpectExpr skipwhite skipempty

syn match   jsltVarReference                /\$/ nextgroup=jsltVarIdentifier,jsltErrBadIdentifier
syn match   jsltVarIdentifier     contained /\%(\w\|-\)\+/ nextgroup=@jsltChainLink,@jsltExpression skipwhite skipempty

syn match   jsltDotKey            contained /\./ nextgroup=jsltString,jsltDotIdentifier skipwhite skipempty
syn match   jsltDotIdentifier     contained /\%(\w\|-\)\+/ nextgroup=@jsltChainLink,@jsltOperator skipwhite skipempty
syn match   jsltDot                         /\./ nextgroup=jsltString,jsltDotIdentifier,jsltArraySlice,@jsltOperator skipwhite skipempty

syn keyword jsltNull                        null nextgroup=@jsltOperator skipwhite skipempty
syn keyword jsltBoolean                     false true nextgroup=@jsltOperator skipwhite skipempty
syn match   jsltNumber                      /\<-\?\%(0\|[1-9]\d*\)\%(\.\d\+\)\?\%([Ee][+-]\?\d\+\)\?\>/ nextgroup=@jsltOperator skipwhite skipempty
syn region  jsltString                      start=/"/ skip=/\\\"\|\\\\/ end=/"/ contains=jsltStringEscape,jsltErrBadEscape nextgroup=@jsltChainLink,@jsltOperator skipwhite skipempty
syn match   jsltStringEscape      contained /\\"\|\\\\/

" TODO: Object reference
" TODO: Object matcher

syn keyword jsltTodo              contained FIXME NOTE TBD TODO XXX
syn region  jsltLineComment                 start="//" end=/$/ contains=@Spell,jsltTodo

syn match   jsltErrBadEscape      contained /\\[^"\\]/
syn match   jsltErrBadIdentifier  contained /\%(\_s\|[0-9A-Za-z_-]\)\@![^()]*/
syn match   jsltErrExpectAs       contained /\%(\_s\|as\>\)\@![^()]*/
syn match   jsltErrExpectAssign   contained /\%(\_s\|=\)\@![^()]*/
syn match   jsltErrExpectComma    contained /\%(\_s\|,\)\@![^()]*/
syn match   jsltErrExpectExpr     contained /\%(\_s\|["$(.\[{0-9A-Za-z_-]\)\@![^()]*/
syn match   jsltErrExpectParens   contained /\%(\_s\|(\)\@![^()]*/
syn match   jsltErrExpectQuote    contained /\%(\_s\|"\)\@![^()]*/

" The default highlight links.  Can be overridden later.

hi def link jsltAssignOp          Operator
hi def link jsltCompareOp         Operator
hi def link jsltArithmeticOp      Operator
hi def link jsltLogicalOp         Operator
hi def link jsltColonOp           Operator
hi def link jsltPipeOp            Operator

hi def link jsltImport            Include
hi def link jsltImportAs          Include

hi def link jsltFunction          Statement
hi def link jsltFnIdentifier      Function

hi def link jsltLet               Statement
hi def link jsltLetIdentifier     Function

hi def link jsltIdentifier        Function
hi def link jsltVarReference      Function
hi def link jsltVarIdentifier     Function

hi def link jsltNull              Constant
hi def link jsltBoolean           Boolean
hi def link jsltNumber            Number
hi def link jsltString            String
hi def link jsltStringEscape      Special

hi def link jsltTodo              Todo
hi def link jsltLineComment       Comment

hi def link jsltIf                Conditional
hi def link jsltElse              Conditional

hi def link jsltArrayFor          Repeat
hi def link jsltObjectFor         Repeat

hi def link jsltErrBadEscape      Error
hi def link jsltErrBadIdentifier  Error
hi def link jsltErrExpectAs       Error
hi def link jsltErrExpectAssign   Error
hi def link jsltErrExpectComma    Error
hi def link jsltErrExpectExpr     Error
hi def link jsltErrExpectParens   Error
hi def link jsltErrExpectQuote    Error
hi def link jsltErrMismatchPunct  Error

let b:current_syntax = "jslt"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set shiftwidth=2 softtabstop=2 tabstop=2 expandtab:
