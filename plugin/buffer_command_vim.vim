if exists("g:loaded_buffer_command_vim")
  finish
endif
let g:loaded_buffer_command_vim = 1

command! BCCloseBuffer call buffer_command_vim#CloseBuffer(0)
command! BCForceCloseBuffer call buffer_command_vim#CloseBuffer(1)
command! BCCloseOtherBuffers call buffer_command_vim#CloseOtherBuffers()
command! BCReloadBuffers call buffer_command_vim#ReloadBuffers()
