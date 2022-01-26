import sys
from prompt_toolkit.key_binding.vi_state import InputMode, ViState


def get_input_mode(self):
    return self._input_mode


def set_input_mode(self, mode):
    shape = {InputMode.NAVIGATION: 1, InputMode.REPLACE: 3}.get(mode, 5)
    out = getattr(sys.stdout, 'buffer', sys.stdout)
    out.write(u'\x1b[{} q'.format(shape).encode('ascii'))
    sys.stdout.flush()
    self._input_mode = mode


ViState._input_mode = InputMode.INSERT
ViState.input_mode = property(get_input_mode, set_input_mode)

c.TerminalInteractiveShell.editing_mode = 'vi'
