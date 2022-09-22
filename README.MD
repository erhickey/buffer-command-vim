# buffer-command-vim

vim plugin that exposes buffer management functions that perform to my personal preference.

## Installation

Install manually or with your favorite plugin manager and add keybindings for the functions listed below.

## Functions

### BCCloseBuffer

Closes the current buffer if it has not been modified. Takes care not to close any active windows. This is achieved by setting the buffer to the previous buffer in any windows currently displaying the buffer to be closed.

### BCForceCloseBuffer

Same as BCCloseBuffer, but it will close the current buffer even if it has been modified.

### BCCloseOtherBuffers

Closes all listed buffers except the current buffer, terminal buffers, and buffers that have been modified. A list of modified buffers that were not closed is printed to the command line bar.

### BCReloadBuffers

Reloads all listed buffers except terminal buffers.
