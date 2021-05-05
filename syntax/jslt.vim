" Vim syntax file
" Language: JSLT
" Maintainer: João Abecasis <joao@abecasis.name>
" URL: https://github.com/schibsted/jslt
" Latest Revision: 5 May 2021

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case match
syn iskeyword @,$,-,_,48-57,192-255

syn cluster jsltTop contains=jsltLineComment,jsltImport,jsltFunction,jsltLet,@jsltExpression
syn cluster jsltExpression contains=jsltParens,jsltArray,jsltObject,@jsltValue,@jsltReference,jsltFunctionCall,jsltIf,jsltElse,@jsltOperator,jsltErrMismatchPunct
syn cluster jsltChainLink contains=jsltDotKey,jsltArraySlice
syn cluster jsltReference contains=jsltVarReference,jsltDot,jsltDotKey
syn cluster jsltValue contains=jsltNull,jsltBoolean,jsltNumber,jsltString
syn cluster jsltOperator contains=jsltAssignOp,jsltCompareOp,jsltArithmeticOp,jsltLogicalOp,jsltColonOp,jsltPipeOp,jsltIf

syn match   jsltErrMismatchPunct              /[$).\]}]/

syn match   jsltComma                   contained ','

syn region  jsltParens                            matchgroup=_jsltParens start=/(/ end=/)/ contains=@jsltExpression,jsltExpressionComment
syn match   jsltIdentifier              contained /\%(\w\|-\)\+/

syn match   jsltIdentifierList          contained /\%(\w\|-\)\+/ nextgroup=jsltIdentifierComma,jsltIdentifierListComment,jsltErrExpectComma skipwhite skipempty
syn match   jsltIdentifierComma         contained /,/ nextgroup=jsltIdentifierList,jsltIdentifierCommaComment,jsltErrBadIdentifier skipwhite skipempty

syn match   jsltFunctionCall                      /\%(\<\%(and\|as\|def\|else\|false\|for\|if\|import\|let\|null\|or\|true\)\>\)\@!\%(\w\|-\)\+\%(:\%(\w\|-\)\+\)\?/ nextgroup=jsltFnArgs,jsltFunctionCallComment skipwhite skipempty
syn region  jsltFnArgs                  contained matchgroup=_jsltFnArgs start=/(/ end=/)/ contains=jsltComma,@jsltExpression,jsltCommaExprComment nextgroup=@jsltChainLink,@jsltExpression,jsltChainLinkExprComment skipwhite skipempty

syn region  jsltArray                             matchgroup=_jsltArray start=/\[/ end=/\]/ contains=jsltComma,@jsltExpression,jsltArrayFor,jsltArrayComment skipwhite skipempty
syn region  jsltArrayLoopCond           contained matchgroup=_jsltArrayLoopCond start=/(/ end=/)/ contains=@jsltExpression,jsltExpressionComment nextgroup=jsltLet,@jsltExpression,jsltLetExpressionComment,jsltErrExpectExpr skipwhite skipempty

syn region  jsltArraySlice              contained matchgroup=_jsltArraySlice start=/\[/ end=/\]/ contains=@jsltExpression,jsltExpressionComment nextgroup=@jsltChainLink,@jsltOperator,jsltChainLinkOpComment skipwhite skipempty

syn region  jsltObject                            matchgroup=_jsltObject start=/{/ end=/}/ contains=jsltComma,jsltLet,@jsltExpression,jsltObjectFor,jsltObjectComment skipwhite skipempty
syn region  jsltObjectLoopCond          contained matchgroup=_jsltObjectLoopCond start=/(/ end=/)/ contains=@jsltExpression,jsltExpressionComment nextgroup=jsltLet,@jsltExpression,jsltLetExpressionComment,jsltErrExpectExpr skipwhite skipempty

syn match   jsltAssignOp                contained /=/ nextgroup=@jsltExpression,jsltExpressionComment,jsltErrExpectExpr skipwhite skipempty
syn match   jsltCompareOp               contained /\%(!=\|<=\|<\|==\|>=\|>\)/ nextgroup=@jsltExpression,jsltExpressionComment,jsltErrExpectExpr skipwhite skipempty
syn match   jsltArithmeticOp            contained "\%(+\|-\|\*\|/\%(/\)\@!\)" nextgroup=@jsltExpression,jsltExpressionComment,jsltErrExpectExpr skipwhite skipempty
syn match   jsltColonOp                 contained /:/ nextgroup=@jsltExpression,jsltExpressionComment,jsltErrExpectExpr skipwhite skipempty
syn match   jsltPipeOp                  contained /|/ nextgroup=@jsltExpression,jsltExpressionComment,jsltErrExpectExpr skipwhite skipempty

syn match   jsltVarReference                      /\$/ nextgroup=jsltVarIdentifier,jsltErrBadIdentifier
syn match   jsltVarIdentifier           contained /\%(\w\|-\)\+/ nextgroup=@jsltChainLink,@jsltExpression,jsltChainLinkExprComment skipwhite skipempty

syn match   jsltDotKey                  contained /\./ nextgroup=jsltString,jsltDotIdentifier,jsltDotKeyComment skipwhite skipempty
syn match   jsltDotIdentifier           contained /\%(\w\|-\)\+/ nextgroup=@jsltChainLink,@jsltOperator,jsltChainLinkOpComment skipwhite skipempty

syn match   jsltDot                               /\./ nextgroup=jsltString,jsltDotIdentifier,jsltArraySlice,@jsltOperator,jsltDotComment skipwhite skipempty

syn keyword jsltImport                            import nextgroup=jsltImportSource,jsltImportComment,jsltErrExpectQuote skipwhite skipempty
syn region  jsltImportSource            contained matchgroup=jsltString start=/"/ skip=/\\"\|\\\\/ end=/"/ contains=jsltStringEscape nextgroup=jsltImportAs,jsltImportSourceComment,jsltErrExpectAs skipwhite skipempty
syn keyword jsltImportAs                contained as nextgroup=jsltIdentifier,jsltIdentifierComment,jsltErrBadIdentifier skipwhite skipempty

syn keyword jsltFunction                          def nextgroup=jsltFnIdentifier,jsltFunctionComment,jsltErrBadIdentifier skipwhite skipempty
syn match   jsltFnIdentifier            contained /\%(\w\|-\)\+/ nextgroup=jsltFnParams,jsltFnIdentifierComment,jsltErrExpectParens skipwhite skipempty
syn region  jsltFnParams                contained matchgroup=_jsltFnParams start=/(/ end=/)/ contains=jsltIdentifierList,jsltIdentifierCommaComment,jsltErrBadIdentifier nextgroup=jsltLet,@jsltExpression,jsltLetExpressionComment,jsltErrExpectExpr skipwhite skipempty

syn keyword jsltLet                               let nextgroup=jsltLetIdentifier,jsltLetComment,jsltErrBadIdentifier skipwhite skipempty
syn match   jsltLetIdentifier           contained "\%(\w\|-\)\+" nextgroup=jsltAssignOp,jsltLetIdentifierComment,jsltErrExpectAssign skipwhite skipempty

syn keyword jsltIf                                if nextgroup=jsltIfCondition,jsltIfComment,jsltErrExpectParens skipwhite skipempty
syn region  jsltIfCondition             contained matchgroup=_jsltIfCondition start=/(/ end=/)/ contains=jsltLet,@jsltExpression,jsltLetExpressionComment,jsltErrExpectExpr nextgroup=jsltLet,@jsltExpression,jsltLetExpressionComment,jsltErrExpectExpr skipwhite skipempty
syn keyword jsltElse                              else nextgroup=jsltLet,@jsltExpression,jsltLetExpressionComment,jsltErrExpectExpr skipwhite skipempty

syn keyword jsltArrayFor                contained for nextgroup=jsltArrayLoopCond,jsltArrayForComment,jsltErrExpectParens skipwhite skipempty
syn keyword jsltObjectFor               contained for nextgroup=jsltObjectLoopCond,jsltObjectForComment,jsltErrExpectParens skipwhite skipempty

syn keyword jsltLogicalOp               contained and or nextgroup=@jsltExpression,jsltExpressionComment,jsltErrExpectExpr skipwhite skipempty

syn keyword jsltNull                              null nextgroup=@jsltOperator,jsltOperatorComment skipwhite skipempty
syn keyword jsltBoolean                           false true nextgroup=@jsltOperator,jsltOperatorComment skipwhite skipempty
syn match   jsltNumber                            /\<-\?\%(0\|[1-9]\d*\)\%(\.\d\+\)\?\%([Ee][+-]\?\d\+\)\?\>/ nextgroup=@jsltOperator,jsltOperatorComment skipwhite skipempty
syn region  jsltString                            start=/"/ skip=/\\\"\|\\\\/ end=/"/ contains=jsltStringEscape,jsltErrBadEscape nextgroup=@jsltChainLink,@jsltOperator,jsltChainLinkOpComment skipwhite skipempty

syn match   jsltStringEscape            contained /\\"\|\\\\/

" TODO: Object matcher
" TODO: Bad import placement?
" TODO: Bad let/def placement?

syn match   jsltErrBadEscape            contained /\\[^"\\]/
syn match   jsltErrBadIdentifier        contained /\%(\_s\|[0-9A-Za-z_-]\)\@![^()]*/
syn match   jsltErrExpectAs             contained /\%(\_s\|as\>\)\@![^()]*/
syn match   jsltErrExpectAssign         contained /\%(\_s\|=\)\@![^()]*/
syn match   jsltErrExpectComma          contained /\%(\_s\|,\)\@![^()]*/
syn match   jsltErrExpectExpr           contained /\%(\_s\|["$(.\[{0-9A-Za-z_-]\)\@![^()]*/
syn match   jsltErrExpectParens         contained /\%(\_s\|(\)\@![^()]*/
syn match   jsltErrExpectQuote          contained /\%(\_s\|"\)\@![^()]*/

syn keyword jsltTodo                    contained FIXME NOTE TBD TODO XXX
syn region  jsltLineComment                       start="//" end=/$/ contains=@Spell,jsltTodo
syn region  jsltArrayComment            contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltComma,@jsltExpression,jsltArrayFor,jsltArrayComment skipwhite skipempty
syn region  jsltArrayForComment         contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltArrayLoopCond,jsltArrayForComment,jsltErrExpectParens skipwhite skipempty
syn region  jsltChainLinkExprComment    contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=@jsltChainLink,@jsltExpression,jsltChainLinkExprComment skipwhite skipempty
syn region  jsltChainLinkOpComment      contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=@jsltChainLink,@jsltOperator,jsltChainLinkOpComment skipwhite skipempty
syn region  jsltCommaExprComment        contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltComma,@jsltExpression,jsltCommaExprComment skipwhite skipempty
syn region  jsltDotComment              contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltString,jsltDotIdentifier,jsltArraySlice,@jsltOperator,jsltDotComment skipwhite skipempty
syn region  jsltDotKeyComment           contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltString,jsltDotIdentifier,jsltDotKeyComment skipwhite skipempty
syn region  jsltExpressionComment       contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=@jsltExpression,jsltExpressionComment,jsltErrExpectExpr skipwhite skipempty
syn region  jsltFnIdentifierComment     contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltFnParams,jsltFnIdentifierComment,jsltErrExpectParens skipwhite skipempty
syn region  jsltFunctionCallComment     contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltFnArgs,jsltFunctionCallComment skipwhite skipempty
syn region  jsltFunctionComment         contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltFnIdentifier,jsltFunctionComment,jsltErrBadIdentifier skipwhite skipempty
syn region  jsltIdentifierCommaComment  contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltIdentifierList,jsltIdentifierCommaComment,jsltErrBadIdentifier skipwhite skipempty
syn region  jsltIdentifierComment       contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltIdentifier,jsltIdentifierComment,jsltErrBadIdentifier skipwhite skipempty
syn region  jsltIdentifierListComment   contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltIdentifierComma,jsltIdentifierListComment,jsltErrExpectComma skipwhite skipempty
syn region  jsltIfComment               contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltIfCondition,jsltIfComment,jsltErrExpectParens skipwhite skipempty
syn region  jsltImportComment           contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltImportSource,jsltImportComment,jsltErrExpectQuote skipwhite skipempty
syn region  jsltImportSourceComment     contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltImportAs,jsltImportSourceComment,jsltErrExpectAs skipwhite skipempty
syn region  jsltLetComment              contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltLetIdentifier,jsltLetComment,jsltErrBadIdentifier skipwhite skipempty
syn region  jsltLetExpressionComment    contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltLet,@jsltExpression,jsltLetExpressionComment,jsltErrExpectExpr skipwhite skipempty
syn region  jsltLetIdentifierComment    contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltAssignOp,jsltLetIdentifierComment,jsltErrExpectAssign skipwhite skipempty
syn region  jsltObjectComment           contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltComma,jsltLet,@jsltExpression,jsltObjectFor,jsltObjectComment skipwhite skipempty
syn region  jsltObjectForComment        contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=jsltObjectLoopCond,jsltObjectForComment,jsltErrExpectParens skipwhite skipempty
syn region  jsltOperatorComment         contained start="//" end=/$/ contains=@Spell,jsltTodo nextgroup=@jsltOperator,jsltOperatorComment skipwhite skipempty

" The default highlight links.  Can be overridden later.

hi def link jsltAssignOp                Operator
hi def link jsltCompareOp               Operator
hi def link jsltArithmeticOp            Operator
hi def link jsltLogicalOp               Operator
hi def link jsltColonOp                 Operator
hi def link jsltPipeOp                  Operator

hi def link jsltImport                  Include
hi def link jsltImportAs                Include

hi def link jsltFunction                Statement
hi def link jsltFnIdentifier            Function

hi def link jsltLet                     Statement
hi def link jsltLetIdentifier           Identifier

hi def link jsltIdentifier              Identifier
hi def link jsltVarReference            Function
hi def link jsltVarIdentifier           Function

hi def link jsltNull                    Constant
hi def link jsltBoolean                 Boolean
hi def link jsltNumber                  Number
hi def link jsltString                  String
hi def link jsltStringEscape            Special

hi def link jsltTodo                    Todo
hi def link jsltLineComment             Comment
hi def link jsltArrayComment            Comment
hi def link jsltArrayForComment         Comment
hi def link jsltChainLinkExprComment    Comment
hi def link jsltChainLinkOpComment      Comment
hi def link jsltCommaExprComment        Comment
hi def link jsltDotComment              Comment
hi def link jsltDotKeyComment           Comment
hi def link jsltExpressionComment       Comment
hi def link jsltFnIdentifierComment     Comment
hi def link jsltFunctionCallComment     Comment
hi def link jsltFunctionComment         Comment
hi def link jsltIdentifierCommaComment  Comment
hi def link jsltIdentifierComment       Comment
hi def link jsltIdentifierListComment   Comment
hi def link jsltIfComment               Comment
hi def link jsltImportComment           Comment
hi def link jsltImportSourceComment     Comment
hi def link jsltLetComment              Comment
hi def link jsltLetExpressionComment    Comment
hi def link jsltLetIdentifierComment    Comment
hi def link jsltObjectComment           Comment
hi def link jsltObjectForComment        Comment
hi def link jsltOperatorComment         Comment

hi def link jsltIf                      Conditional
hi def link jsltElse                    Conditional

hi def link jsltArrayFor                Repeat
hi def link jsltObjectFor               Repeat

hi def link jsltErrBadEscape            Error
hi def link jsltErrBadIdentifier        Error
hi def link jsltErrExpectAs             Error
hi def link jsltErrExpectAssign         Error
hi def link jsltErrExpectComma          Error
hi def link jsltErrExpectExpr           Error
hi def link jsltErrExpectParens         Error
hi def link jsltErrExpectQuote          Error
hi def link jsltErrMismatchPunct        Error

let b:current_syntax = "jslt"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set shiftwidth=2 softtabstop=2 tabstop=2 expandtab:
