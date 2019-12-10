" MIT License. Copyright (c) 2013-2019 Bailey Ling et al.

scriptencoding utf-8

" The custom.vim theme:
let s:palette = {}

let s:a_normal      = [ '', '', 235, 3, '' ]
let s:a_insert      = [ '', '', 248, 17, '' ]
let s:a_replace     = [ '', '', 17, 124, '' ]
let s:a_visual      = [ '', '', 232, 90, '' ]
let s:a_inactive    = [ '', '', 239, 234, '' ]
let s:a_commandline = [ '', '', 17, 40, '' ]

let s:b = [ '', '', 255, 238, '' ]
let s:c = [ '', '', 85, 234, '' ]

let s:basic_palette = airline#themes#generate_color_map(s:a_normal, s:b, s:c)

let s:modified = {
    \ 'airline_c': [ '', '', 166, '', '' ],
    \ }

let s:palette.normal = copy(s:basic_palette)
let s:palette.normal.airline_y = s:c
let s:palette.normal_modified = s:modified

let s:palette.insert = copy(s:basic_palette)
let s:palette.insert.airline_a = [ '', '', 248, 17, '' ]
let s:palette.insert.airline_z = [ '', '', 248, 17, '' ]
let s:palette.insert_modified = s:modified

let s:palette.replace = copy(s:basic_palette)
let s:palette.replace.airline_a = [ '', '', 17, 124, '' ]
let s:palette.replace.airline_z = [ '', '', 17, 124, '' ]
let s:palette.replace_modified = s:modified

let s:palette.visual = copy(s:basic_palette)
let s:palette.visual.airline_a = [ '', '', 232, 90, '' ]
let s:palette.visual.airline_z = [ '', '', 232, 90, '' ]
let s:palette.visual_modified = s:modified

let s:palette.inactive = copy(s:basic_palette)
let s:palette.inactive.airline_a = [ '', '', 239, 234, '' ]
let s:palette.inactive.airline_z = [ '', '', 239, 234, '' ]
let s:palette.inactive_modified = s:modified

let s:palette.commandline = copy(s:basic_palette)
let s:palette.commandline.airline_a = [ '', '', 17, 40, '' ]
let s:palette.commandline.airline_z = [ '', '', 17, 40, '' ]
let s:palette.commandline_modified = s:modified

let s:palette.accents = {
      \ 'red': [ '', '', 160, '' ]
      \ }

let g:airline#themes#custom#palette = s:palette

