" Vim plugin to fit the Open vSwitch coding style.
" Maintainer:   Flavio Leitner <fbl@sysclose.org>
" License:      Distributed under the same terms as Vim itself.
"
" This script is based on the great Linux kernel's script written
" by Vivien Didelot.

" OVS supports at least three different coding styles.  This script
" attempts to cover the kernel datapath which follows Linux kernel's
" coding style and the Open vSwitch coding style.  The Windows datapath
" has another style but the current script lacks support for it.

command! LoadCodingStyle call s:StyleConfigure()
if exists("g:projects_ovs_loaded")
    finish
endif
let g:projects_ovs_loaded = 1

function s:StyleConfigure()
    let path = expand('%:p')
    if path =~? '/datapath/'
        call s:LinuxCodingStyle()
    elseif path =~? '/datapath-windows/'
        call s:WindowCodingStyle()
    else
        call s:OVSCodingStyle()
    endif
endfunction

function s:LinuxCodingStyle()
    call s:LinuxFormatting()
    call s:LinuxKeywords()
    call s:LinuxHighlighting()
endfunction

function s:WindowsCodingStyle()
    " Volunteers? 
endfunction

function s:OVSCodingStyle()
    echo "OVS"
    call s:OVSFormatting()
    call s:OVSKeywords()
    call s:OVSHighlighting()
endfunction

function s:LinuxFormatting()
    setlocal tabstop=8
    setlocal shiftwidth=8
    setlocal softtabstop=8
    setlocal textwidth=80
    setlocal noexpandtab

    setlocal cindent
    setlocal cinoptions=:0,l1,t0,g0,(0
endfunction

function s:LinuxKeywords()
    syn keyword cOperator likely unlikely
    syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
    syn keyword cType __u8 __u16 __u32 __u64 __s8 __s16 __s32 __s64
endfunction

function s:LinuxHighlighting()
    highlight default link LinuxError ErrorMsg

    syn match LinuxError / \+\ze\t/     " spaces before tab
    syn match LinuxError /\%81v.\+/     " virtual column 81 and more

    " Highlight trailing whitespace, unless we're in insert mode and the
    " cursor's placed right after the whitespace. This prevents us from having
    " to put up with whitespace being highlighted in the middle of typing
    " something
    autocmd InsertEnter * match LinuxError /\s\+\%#\@<!$/
    autocmd InsertLeave * match LinuxError /\s\+$/
endfunction

function s:OVSFormatting()
    setlocal tabstop=4
    setlocal shiftwidth=4
    setlocal softtabstop=4
    setlocal textwidth=80
    setlocal expandtab

    setlocal cindent
    setlocal cinoptions=:0,l1,t0,g0,(0,c3,b0,^0,{0,}0,n0,
endfunction

function s:OVSKeywords()
    syn keyword cOperator likely unlikely
    syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
    syn keyword cType __u8 __u16 __u32 __u64 __s8 __s16 __s32 __s64
endfunction

function s:OVSHighlighting()
    highlight default link OVSError ErrorMsg

    syn match OVSError / \+\ze\t/     " spaces before tab
    syn match OVSError /\%81v.\+/     " virtual column 81 and more

    " Highlight trailing whitespace, unless we're in insert mode and the
    " cursor's placed right after the whitespace. This prevents us from having
    " to put up with whitespace being highlighted in the middle of typing
    " something
    autocmd InsertEnter * match OVSError /\s\+\%#\@<!$/
    autocmd InsertLeave * match OVSError /\s\+$/
endfunction

" vim: ts=4 et sw=4
