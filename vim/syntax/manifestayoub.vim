" Vim syntax file
" Language:    manifestayoub  — link-dotfiles manifest (manifest.txt)
" Purpose:     Split every directive line into its fields so each field can be
"              coloured on its own. This file only PARSES: the colours at the
"              bottom are default links you are meant to override later.
"
" Line shapes (see the manifest.txt header for the full spec):
"
"     SOURCE|TARGET
"     SOURCE|TARGET|PERMS[|PLATFORM][|sudo]
"     COMMAND|SOURCE|TARGET|PERMS[|PLATFORM][|sudo]
"
"   COMMAND  is one of LN CP MV (uppercase).
"   PLATFORM is empty / "universe" / an os-release token / wsl / termux.
"   sudo     is the literal word "sudo". The shorthand  ...|PERMS|sudo  puts it
"            in the PLATFORM slot; that word always reads as sudo there, never
"            as a platform name.
"   Blank lines and  # comments  (leading indentation allowed) are ignored.

if exists("b:current_syntax")
  finish
endif

" COMMAND (LN/CP/MV), the platform tokens and the word sudo are all case
" sensitive, so match case exactly.
syntax case match

" --- comments ---------------------------------------------------------------
" a whole-line comment: optional indent, then # to end of line
syntax match manifestayoubComment "^\s*#.*$"

" --- field separators -------------------------------------------------------
" One pipe per slot. Each pipe hands off (nextgroup) to whatever field comes
" next, which is how the line is walked left to right. They share one colour.
syntax match manifestayoubSepSrc  "|" contained nextgroup=manifestayoubTarget
syntax match manifestayoubSepTgt  "|" contained nextgroup=manifestayoubPerms
syntax match manifestayoubSepPerm "|" contained nextgroup=manifestayoubPlatform,manifestayoubSudo
syntax match manifestayoubSepPlat "|" contained nextgroup=manifestayoubSudo
syntax match manifestayoubSepCmd  "|" contained nextgroup=manifestayoubSourceCmd

" --- shape 3: COMMAND | SOURCE | ... ---------------------------------------
" An uppercase LN/CP/MV sitting right in front of a pipe starts the command
" chain ( |\@= is a look-ahead, so the pipe is left for the separator below ).
syntax match manifestayoubCommand "^\s*\zs\%(LN\|CP\|MV\)|\@=" nextgroup=manifestayoubSepCmd
syntax match manifestayoubSourceCmd "[^|]\+" contained nextgroup=manifestayoubSepSrc

" --- shapes 1 & 2: SOURCE | TARGET | ... -----------------------------------
" First field of a plain line. The look-aheads keep it off comment lines (#)
" and off command lines (LN|/CP|/MV|), which are handled by the rules above.
syntax match manifestayoubSource "^\s*#\@!\%(\%(LN\|CP\|MV\)|\)\@!\zs[^|]\+" nextgroup=manifestayoubSepSrc

" --- the shared tail, reached by both chains --------------------------------
" PERMS/PLATFORM allow an empty field so the  SOURCE|TARGET|PERMS||sudo  form
" (empty platform, then sudo) still walks cleanly to the trailing sudo.
syntax match   manifestayoubTarget   "[^|]*" contained nextgroup=manifestayoubSepTgt
syntax match   manifestayoubPerms    "[^|]*" contained nextgroup=manifestayoubSepPerm
syntax match   manifestayoubPlatform "[^|]*" contained nextgroup=manifestayoubSepPlat
" keyword, so the literal word sudo always wins the PLATFORM slot over a match
syntax keyword manifestayoubSudo     sudo    contained

" --- default colours (re-link any of these groups to recolour) -------------
highlight default link manifestayoubComment    Comment
highlight default link manifestayoubCommand    Statement
highlight default link manifestayoubSource     Identifier
highlight default link manifestayoubSourceCmd  Identifier
highlight default link manifestayoubTarget     Type
highlight default link manifestayoubPerms      Number
highlight default link manifestayoubPlatform   Constant
highlight default link manifestayoubSudo       Special
highlight default link manifestayoubSepSrc     Delimiter
highlight default link manifestayoubSepTgt     Delimiter
highlight default link manifestayoubSepPerm    Delimiter
highlight default link manifestayoubSepPlat    Delimiter
highlight default link manifestayoubSepCmd     Delimiter

let b:current_syntax = "manifestayoub"
