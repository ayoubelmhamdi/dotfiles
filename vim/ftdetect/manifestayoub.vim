" Filetype detection for the link-dotfiles manifest.
" Matches manifest.txt and suggested_manifest.txt (in any directory) plus the
" *.manifestayoub extension, so both this repo's manifest and the generated
" suggestion light up.
"
" These use  set filetype=  (force), not setfiletype, on purpose: nvim/vim ship
" a built-in  *.txt -> text  rule, and setfiletype would quietly lose to it.
autocmd BufRead,BufNewFile manifest.txt,suggested_manifest.txt set filetype=manifestayoub
autocmd BufRead,BufNewFile *.manifestayoub                      set filetype=manifestayoub
