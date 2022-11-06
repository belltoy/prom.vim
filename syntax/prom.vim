" Vim syntax file
" Language:               Prometheus exposition text format
" Version:                1.0
" Original Author:        Zhongqiu Zhao <belltoy@gmail.com>
" Current Maintainer:     Zhongqiu Zhao <belltoy@gmail.com>
" Last Change:            2022 Nov 06


" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword promLineType HELP TYPE contained
syn keyword promMetricsType counter gauge histogram summary untyped contained

syn match   promDelimiters "[{}=,]" contained
syn keyword promPredefinedLabel le quantile contained
syn region promString start=/"/ end=/"/ skip=/\\"/
syn region promLabelValue start=/=\s*"/ms=e+1 end=/"/ skip=/\\"/
syn match  promEq /\s*=\s*/ contained
syn match  promLabels "{.*}" contains=promString,promDelimiters,promLabelValue,promEq,promPredefinedLabel contained

syn match  promNameSuffix "_bucket\|_count\|_sum" contained
syn match  promNameComment "[a-zA-Z_][a-zA-Z0-9_]*" contained

syn match  promNumber   "\(\s*\d\+\s*\)\?\s*[+-]\?\d\+\s*$"
syn match  promNumber   "\(\s*[+-]\?Inf\s*\)\?\s*[+-]\?\d\+\s*$"
syn match  promNumber   "\s*\d*\.\d\+\s*\(\s*[+-]\?\d\+\s*\)\?$"
syn match  promNumber   "\s*\d\+\(\.\d\+\)\?e[+-]\=\d\+\s*\(\s*[+-]\?\d\+\s*\)\?$"

syn match promName        /^[^#]\s*[a-zA-Z_][a-zA-Z0-9_]*\(\s\|{\)/me=e-1 contains=promNameSuffix contained
syn match promMetricsLine "^[^#].*$" contains=promName,promNameSuffix,promLabels,promNumber

syn match promHelpLine "^#\s*HELP\s\+\S\+\s\+"ms=s+1 contains=promLineType,promNameComment contained
syn match promTypeLine "^#\s*TYPE\s\+\S\+\s\+\S\+$"ms=s+1 contains=promLineType,promMetricsType,promNameComment contained
syn match promComment  "^[#].*$" contains=promLineType,promHelpLine,promTypeLine keepend

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

hi def link promDelimiters  Delimiter
hi def link promMetricsType Debug
hi def link promName        Function
hi def link promNameSuffix  SpecialChar
hi def link promNameComment Identifier
hi def link promNumber      Number
hi def link promPredefinedLabel Constant

hi def link promEq          Operator
hi def link promLabels      Structure
hi def link promString      String
hi def link promLineType    Keyword

hi def link promHelpLine    Identifier
hi def link promComment     Comment

let b:current_syntax = "prom"

" vim: sts=2 sw=2 et
