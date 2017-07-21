" File: projects.vim
" Author: Flavio Leitner (fbl AT sysclose DOT org)
" Version: 0.3
" Last Modified: August 05, 2016
" Copyright: Copyright (C) 2016 Flavio Leitner
"            Permission is hereby granted to use and distribute this code,
"            with or without modifications, provided that this copyright
"            notice is copied with it. Like anything else that's free,
"            projects.vim is provided *as is* and comes with no warranty of any
"            kind, either expressed or implied. In no event will the copyright
"            holder be liable for any damamges resulting from the use of this
"            software.
"

"set verbose=9
function! s:LoadProject(path)
    let b:projects_config_path = "~/.vim/projects"
    " default plugin
    let b:projects_plugin = 'kernel.vim'
    " check if this is an OVS repo
    if a:path =~? 'ovs/[^datapath]'
        let b:projects_plugin = 'ovs.vim'
    endif

    " load the style
    if exists("b:projects_plugin")
        let b:project_module_file = fnameescape(b:projects_config_path . '/' . b:projects_plugin)
        execute 'source '.b:project_module_file
        LoadCodingStyle
    endif
endfun

augroup projects
    autocmd!
    autocmd BufNewFile,BufRead * call s:LoadProject(expand("<afile>:p:~"))
augroup end

" vim: ts=4 et sw=4
