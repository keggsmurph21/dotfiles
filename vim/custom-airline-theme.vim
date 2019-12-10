" MIT License. Copyright (c) 2013-2019 Bailey Ling et al.
" vim: et ts=4 sts=2 sw=2 tw=80

scriptencoding utf-8

" The custom.vim theme:
let g:airline#themes#custom#palette = {}

let s:a_normal = [ '', '', 235, 3, '' ]
let s:b_normal = [ '', '', 255, 238, '' ]
let s:c_normal = [ '', '', 85, 234, '' ]
let g:airline#themes#custom#palette.normal = airline#themes#generate_color_map(s:a_normal, s:b_normal, s:c_normal)
let g:airline#themes#custom#palette.normal_modified = {
      \ 'airline_c': [ '', '', 255, '', '' ],
      \ }

let g:airline#themes#custom#palette.insert = copy(g:airline#themes#custom#palette.normal)
let g:airline#themes#custom#palette.insert.airline_a = [ '', '', 17, 45, '' ]

let g:airline#themes#custom#palette.replace = copy(g:airline#themes#custom#palette.normal)
let g:airline#themes#custom#palette.replace.airline_a = [ '', '', 17, 124, '' ]

let g:airline#themes#custom#palette.visual = copy(g:airline#themes#custom#palette.normal)
let g:airline#themes#custom#palette.visual.airline_a = [ '', '', 232, 214, '' ]

let g:airline#themes#custom#palette.inactive = copy(g:airline#themes#custom#palette.normal)
let g:airline#themes#custom#palette.inactive.airline_a = [ '', '', 239, 234, '' ]
let g:airline#themes#custom#palette.inactive_modified = {
      \ 'airline_c': [ '', '', 97, '', '' ],
      \ }

let g:airline#themes#custom#palette.commandline = copy(g:airline#themes#custom#palette.normal)
let g:airline#themes#custom#palette.commandline.airline_a = [ '', '', 17, 40, '' ]

let g:airline#themes#custom#palette.accents = {
      \ 'red': [ '', '', 160, '' ]
      \ }

