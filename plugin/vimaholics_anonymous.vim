" Vim global plugin providing anonymous functions for VimL
" Maintainer:	Barry Arthur <barry.arthur@gmail.com>
" Version:	0.1
" Description:	Anonymous function declaration and evaluation
" Last Change:	2014-02-11
" License:	Vim License (see :help license)
" Location:	plugin/vimaholics_anonymous.vim
" Website:	https://github.com/dahu/vimaholics_anonymous
"
" See vimaholics_anonymous.txt for help.  This can be accessed by doing:
"
" :helptags ~/.vim/doc
" :help vimaholics_anonymous

" Vimscript Setup: {{{1
" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" load guard
if exists("g:loaded_vimaholics_anonymous")
      \ || v:version < 700
      \ || &compatible
  let &cpo = s:save_cpo
  finish
endif
let g:loaded_vimaholics_anonymous = 1

let s:fn_idx = 0
function! Fn(fn_form)
  let [fn_args, fn_body] = split(a:fn_form, '\s*=>\s*')
  let s:fn_idx = s:fn_idx + 1
  let fname = 'AnonFn_' . s:fn_idx
  let b_elems = split(fn_body, '|')
  let b_elems[-1] = 'return ' . b_elems[-1]
  exe 'func! ' . fname . fn_args . "\n"
        \. join(b_elems, "\n") . "\n"
        \. 'endfunc'
  return function(fname)
endfunction

function! Fx(fn, ...)
  return call(a:fn, a:000)
endfunction

" Teardown:{{{1
"reset &cpo back to users setting
let &cpo = s:save_cpo

" Template From: https://github.com/dahu/Area-41/
" vim: set sw=2 sts=2 et fdm=marker:
