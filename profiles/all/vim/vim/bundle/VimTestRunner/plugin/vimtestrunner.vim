" ============================================================================
" File:        vimtestrunner - A generic test runner for Vim
" Description: Runs tests for current file (<leader>y) or whole project
"              (<leader>a), showing a green bar if all tests passed or a red
"              bar on failure, jumping to the spec line that failed.
" Author:      Barry Arthur <barry dot arthur at gmail dot com>
" Last Change: 4 February, 2011
" Website:     http://github.com/dahu/VimTestRunner
" Credits:     Stolen from http://gremu.net/blog/2010/integrate-your-python-test-runner-vim/
"              Who in turn stole it from Gary Bernhardt :)
"
" Adapted to work for ruby's rspec output
" NOT tested by me with django - left in to suggest this could be made generic
"
" See vimtestrunner.txt for help.  This can be accessed by doing:
"
" :helptags ~/.vim/doc
" :help vimtestrunner
"
" Licensed under the same terms as Vim itself.
" ============================================================================
let s:VimTestRunner_version = '0.0.2'  " alpha, usable
"
" Vimscript setup {{{1
let s:old_cpo = &cpo
set cpo&vim

" Configuration {{{1
" TODO: don't just zero these - add to them if they already exist
let g:makeprgs = {}
let g:errorformats = {}

let g:makeprgs['django_file'] = 'bin/django\ test\ -v\ 0'
let g:makeprgs['django_project'] = 'bin/test'

" Note: Actual makeprgs here might be very different in the wild. This
" is just a dummy value for now.
let g:makeprgs['ruby_file'] = 'rspec\ -I.\ '
let g:makeprgs['ruby_project'] = 'rspec\ -I.\ *_spec.rb'

let g:errorformats['django'] = '%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m'
let g:errorformats['ruby'] = '%A\ \ %n)%.%#,%C\ %#Failure/Error:\ %m,%C\ %#%*\\sError:,%Z\ %##\ %f:%l:%.%#,%C\ %#%m,%-G%.%#'

" Private Functions {{{1
" TODO: consider making these script local... would the user want to be able
" to call them...?
function! RunTestsForFile(args)
  call RunTests(expand('%:r').'_spec.rb', a:args)
endfunction

function! RunTests(target, args)
  silent w
  " Allow user to override filetype lookup in g:makeprgs and g:errorformats if
  " &filetype is not sufficient
  if exists("b:make_filetype")
    let b:ft = b:make_filetype
  else
    let b:ft = &filetype
  endif
  let &errorformat = g:errorformats[b:ft]
  if len(a:target)
    execute 'set makeprg=' . g:makeprgs[b:ft.'_file']
  else
    execute 'set makeprg=' . g:makeprgs[b:ft.'_project']
  endif
  silent call RunMake(a:target . " " . a:args)
endfunction

function! RunMake(args)
  let l:sp = &shellpipe
  let &shellpipe = '2>&1 >'
  exec "make! " . a:args
  let &shellpipe = l:sp
endfunction

function! JumpToError()
  let has_valid_error = 0
  for error in getqflist()
    if error['valid']
      let has_valid_error = 1
      break
    endif
  endfor
  if has_valid_error
    let error_message = substitute(substitute(error['text'], '^\W*', '', ''), '\n', ' ', 'g')
    let bufnr = error['bufnr']
    let winnr = bufwinnr(bufnr)
    if winnr == -1
      exec "sbuffer " . error['bufnr']
    else
      exec winnr . "wincmd w"
    end
    silent cc!
    wincmd p
    redraw!
    return [1, error_message]
  else
    redraw!
    return [0, "All tests passed"]
  endif
endfunction

function! RedBar(message)
  hi RedBar term=reverse ctermfg=white ctermbg=red guibg=red guifg=white
  echohl RedBar
  echon repeat(" ",&columns - 1) . "\r" . a:message
  echohl
endfunction

function! GreenBar(message)
  hi GreenBar ctermfg=black ctermbg=green guibg=green guifg=black
  echohl GreenBar
  echon repeat(" ",&columns - 1) . "\r" . a:message
  echohl
endfunction

function! ShowBar(response)
  if a:response[0]
    call RedBar(a:response[1])
  else
    call GreenBar(a:response[1])
  endif
endfunction

" Maps {{{1
" TODO: add clash and override checks
nnoremap <leader>a :call RunTests('', '')<CR>:call ShowBar(JumpToError())<CR>
nnoremap <leader>y :call RunTestsForFile('')<CR>:call ShowBar(JumpToError())<CR>

" Teardown:{{{1
"reset &cpo back to users setting
let &cpo = s:old_cpo

" vim: set sw=2 sts=2 et fdm=marker:
