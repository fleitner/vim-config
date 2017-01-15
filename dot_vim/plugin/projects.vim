" File: projects.vim
" Author: Flavio Leitner (fbl AT sysclose DOT org)
" Version: 0.1
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

if exists("g:loaded_projects")
    finish
endif
let g:loaded_projects = 1
let s:projects_config_path = "/home/fleitner/.vim/projects"

" expand path and identify the project to load the correct config
let path = expand('%:p')
if path =~? '/net-next/'
    let g:project_plugin = 'kernel.vim'
elseif path =~? '/linux/'
    let g:project_plugin = 'kernel.vim'
elseif path =~? '/linux-stable/'
    let g:project_plugin = 'kernel.vim'
elseif path =~? '/rhel5/'
    let g:project_plugin = 'kernel.vim'
elseif path =~? '/rhel6/'
    let g:project_plugin = 'kernel.vim'
elseif path =~? '/rhel7/'
    let g:project_plugin = 'kernel.vim'
elseif path =~? 'dpdk/'
    let g:project_plugin = 'kernel.vim'
elseif path =~? 'ovs/'
    let g:project_plugin = 'ovs.vim'
endif

if exists("g:project_plugin")
    let s:project_module_file = fnameescape(s:projects_config_path . '/' . g:project_plugin)
    if filereadable(s:project_module_file)
        execute 'source '.s:project_module_file
    endif
endif

" vim: ts=4 et sw=4
