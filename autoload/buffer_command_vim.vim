function! buffer_command_vim#IsTerminalBuffer(bn)
  return getbufvar(a:bn, '&buftype') == 'terminal'
endfunction

function! buffer_command_vim#SetActiveWindow(winnr)
  if a:winnr > -1
    execute a:winnr.'wincmd w'
  endif
endfunction

function! buffer_command_vim#CloseBuffer(ignore_changes)
  let bang = a:ignore_changes ? '!' : ''
  let current_buf_nr = bufnr('')

  if getbufvar(current_buf_nr, '&mod') && !a:ignore_changes
    echohl ErrorMsg
    echomsg('No write since last change for buffer')
    echohl None
    return
  endif

  if winnr('$') > 1
    let current_window_nr = winnr()
    let ix = 1
    let num_windows = winnr('$')

    while ix <= num_windows
      if current_buf_nr == winbufnr(ix)
        call buffer_command_vim#SetActiveWindow(ix)
        execute 'bprevious'
      endif

      let ix += 1
    endwhile

    call buffer_command_vim#SetActiveWindow(current_window_nr)
    execute current_buf_nr.'bdelete'.bang
  else
    execute 'bdelete'.bang
  endif
endfunction

function! buffer_command_vim#CloseOtherBuffers()
  let modified_buffers = []
  let current_buf_nr = bufnr('')

  for b in getbufinfo({ 'buflisted': 1 })
    if b.bufnr != current_buf_nr && !buffer_command_vim#IsTerminalBuffer(b.bufnr)
      if getbufvar(b.bufnr, '&mod')
        let modified_buffers += [bufname(b.bufnr)]
      else
        execute 'bd'.b.bufnr
      endif
    endif
  endfor

  if len(modified_buffers) > 0
    let names = join(modified_buffers, ", ")
    echomsg('No write since last change for buffers: '.names)
  endif
endfunction

function! buffer_command_vim#ReloadBuffers()
  let current_buf_nr = bufnr('')

  for b in getbufinfo({ 'buflisted': 1 })
    if !buffer_command_vim#IsTerminalBuffer(b.bufnr)
      execute b.bufnr.'bufdo e!'
    endif
  endfor

  execute 'b'.current_buf_nr
endfunction
