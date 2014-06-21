let F2S = Partial('printf', '%f', g:undefined)

echo F2S(3.14)

function! Add(x, y)
  return a:x + a:y
endfunction

let Add10 = Partial('Add', 10, undefined)

echo Fx(Add10, 20)

let qflist1 = [
      \{
      \ 'lnum': 1,
      \ 'bufnr': 2,
      \ 'col': 11,
      \ 'valid': 1,
      \ 'vcol': 0,
      \ 'nr': 0,
      \ 'type': '',
      \ 'pattern': '',
      \ 'text': 'function! Curry(...)'
      \},
      \{
      \ 'lnum': 15,
      \ 'bufnr': 2,
      \ 'col': 15,
      \ 'valid': 1,
      \ 'vcol': 0,
      \ 'nr': 0,
      \ 'type': '',
      \ 'pattern': '',
      \ 'text': 'let Add10_b = Curry(''Add'', 10)'
      \}
      \]
let qflist2 = [
      \{
      \ 'lnum': 2,
      \ 'bufnr': 2,
      \ 'col': 11,
      \ 'valid': 1,
      \ 'vcol': 0,
      \ 'nr': 0,
      \ 'type': '',
      \ 'pattern': '',
      \ 'text': 'function! Curry(...)'
      \},
      \{
      \ 'lnum': 16,
      \ 'bufnr': 2,
      \ 'col': 15,
      \ 'valid': 1,
      \ 'vcol': 0,
      \ 'nr': 0,
      \ 'type': '',
      \ 'pattern': '',
      \ 'text': 'let Add10_b = Curry(''Add'', 10)'
      \}
      \]

let GetLnums = Partial('Map', Get('lnum'), undefined)

echo GetLnums(qflist1)
echo GetLnums(qflist2)

