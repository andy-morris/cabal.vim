" Syntax file for cabal files
" Author:   Andy Morris
" License:  Same as Vim

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "cabal"

if version < 600
  syntax clear
endif

setlocal iskeyword=a-z,A-Z,48-57,_,-,.
syn case ignore

syn region cabalComment start='^\s*\zs--' end='$' oneline contains=TODO
hi def link cabalComment Comment

syn keyword cabalBlock library
syn keyword cabalBlock skipwhite nextgroup=cabalBlockId executable test-suite
syn keyword cabalBlock skipwhite nextgroup=cabalSRId benchmark source-repository
hi def link cabalBlock Structure

syn match cabalBlockId '\k\+' contained
hi def link cabalBlockId Identifier

syn keyword cabalSRId this head contained
hi def link cabalSRThisHead Identifier

syn keyword cabalKeyName contained
  \ name version cabal-version build-type license license-file
  \ license-files copyright maintainer stability homepage package-url
  \ bug-reports synopsis description category author tested-with
  \ data-files data-dir extra-source-files extra-tmp-files extra-doc-files
  \ exposed-modules reexported-modules required-signatures exposed-signatures
  \ exposed
  \ main-is
  \ type test-module
  \ buildable build-tools build-depends cpp-options cc-options ld-options
  \ pkgconfig-depends frameworks c-sources js-sources default-language
  \ other-languages default-extensions other-extensions
  \ extra-libraries extra-ghci-libraries extra-lib-dirs includes
  \ install-includes include-dirs hs-source-dirs other-modules
  \ ghc-prof-options ghcjs-prof-options ghc-shared-options ghcjs-shared-options
  \ ghc-options ghcjs-options jhc-options
  \ description default manual
  \ location module branch tag subdir
syn match cabalKeyName contained '\<x-\k+\>'
hi def link cabalKeyName Label

syn keyword cabalKeyNameOld contained
  \ extensions hugs-options nhc98-options
hi def link cabalKeyNameOld SpellRare

syn match cabalKey '^\s*\zs\k\+:' transparent
  \ contains=cabalKeyName,cabalKeyBad,cabalKeyNameOld,cabalColon

syn match cabalKeyBad '\<\k\+\>' contained
hi def link cabalKeyBad SpellBad

syn match cabalVersion '\<\d\+\(\.\d\+\)*\(\>\|\.\*\)'
hi def link cabalVersion Number

syn match cabalVersionOp '\(<\|>\)=\?\|==\|&&\|||\|!'
hi def link cabalVersionOp Operator

syn match cabalColon ':' contained

syn match cabalParBreak '^\s*\.\s*$'
hi def link cabalParBreak Comment

syn keyword cabalBool True False
hi def link cabalBool Constant

syn keyword cabalIf if else
hi def link cabalIf Keyword

syn match cabalFunCall '\k\+(' transparent contains=cabalFun

syn keyword cabalFun contained os arch impl flag
hi def link cabalFun Function

syn match cabalTabErr '^\s*\zs\t'
hi def link cabalTabErr Error
