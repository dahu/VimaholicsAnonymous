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
  if stridx(fn_body, 'return') == -1
    let b_elems[-1] = 'return ' . b_elems[-1]
  endif
  exe 'func! ' . fname . fn_args . " dict \n"
        \. join(b_elems, "\n") . "\n"
        \. 'endfunc'
  return function(fname)
endfunction

function! Fx(fn, ...)
  return call(a:fn, a:000)
endfunction

" Partial Application {{{1

let g:undefined = {'__undefined__' : '__undefined__'}

function! PartialHelper(orig_args, ...)
  let orig_args = a:orig_args
  if a:0 == 1
    if type(a:1) == type([])
      let args = a:1
    else
      let args = [a:1]
    endif
  else
    let args = a:000
  endif
  let args_len = len(args)
  let arg = 0
  let i = 0
  for A in orig_args
    if arg >= args_len
      break
    endif

    if (type(A) == type({})) && (A == g:undefined)
      let orig_args[i] = args[arg]
      let arg += 1
    endif

    let i += 1
    unlet A
  endfor
  return orig_args
endfunction

function! Partial(func, ...)
  let args = a:000
  return Fn('(...) => return call(' . string(a:func) . ', '
        \. 'PartialHelper(' . string(args) . ', a:000))')
endfunction

function! Map(func, list)
  return map(copy(a:list), 'Fx(Partial(a:func, v:val))')
endfunction

function! GetProp(object, property)
  return a:object[a:property]
endfunction

let Get = Fn('(prop) => Partial("GetProp", g:undefined, a:prop)')

" Reduce {{{1

function! Reduce(func, identity, list)
  let value = a:identity
  for e in a:list
    let value = call(a:func, [value, e])
  endfor
  return value
endfunction


" Teardown:{{{1
"reset &cpo back to users setting
let &cpo = s:save_cpo

" Template From: https://github.com/dahu/Area-41/
" vim: set sw=2 sts=2 et fdm=marker:
