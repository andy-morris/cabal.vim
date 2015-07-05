" Cabal file indentation

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal autoindent indentexpr=CabalIndent(v:lnum)
setlocal indentkeys=!^F,=~else,0{,0},o,O,

fun! s:previndent(l)
  let l:l = a:l
  let l:i = indent(l:l)
  while l:l > 0
    let l:i2 = indent(l:l)
    if l:i2 < l:i
      return l:i2
    endif
    let l:l -= 1
  endw
  return 0
endf

fun! CabalIndent(l)
  let l:prev = getline(a:l-1)
  if a:l == 1 || l:prev =~ '^\s*$' " first or empty line
    return 0
  endif
  if l:prev =~ '^\s*\k\+:$' " cabal key
    return indent(a:l-1) + shiftwidth()
  endif
  if cabal#last_key(a:l-1) == 'description'
    return indent(a:l-1)
  endif
  if l:prev =~ ',$'
    " ends with comma
    if l:prev =~ '^\s*\k\+:'
      " key on same line, indent up to value
      return match(l:prev, ':\s*\zs\S')
    else
      " just value, reuse indent
      return indent(a:l-1)
    endif
  endif
  if l:prev =~ '^\s*\(if\|else\)\>'
    " after if/else
    return indent(a:l-1) + shiftwidth()
  endif
  if l:prev =~ '^\s*\k\+:\s*\S'
    " key & value on same line
    return indent(a:l-1)
  endif
  if l:prev =~ '^executable\|library\|test-suite\|benchmark\|source-repository'
    return indent(a:l-1) + shiftwidth()
  endif
  return s:previndent(a:l) " end of value, probably
endf

fun! cabal#last_key(l)
  let l:l = a:l
  let l:match = []
  while l:match == []
    if l:l <= 0
      return ''
    endif
    let l:match = matchlist(getline(l:l), '^\s*\(\k\+\):')
    let l:l -= 1
  endw
  return l:match[1]
endf
