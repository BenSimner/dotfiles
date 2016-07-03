#!/usr/bin/env python

import os
import sys
import math
from bdb import Bdb

def trace(fName):
    with open(fName, 'r') as f:
        program = f.readlines()

    s = ''.join(program)
    t = Tdb(program)
    t._wait()
    t.run(s, globals={'print': t._print})
    t.print_list(t._previous_frame)
    print()
    print('DONE.')


class Tdb(Bdb):
    def __init__(self, program):
        super().__init__()
        self._program = program
        self._previous_frame = None
        self._previous_line = 1
        self._print_args = None

    def _print(self, *args):
        self._print_args = args

    def _wait(self):
        input('> press [ENTER] to continue.')
        os.system('cls' if os.name == 'nt' else 'clear')

    def print_list(self, frame):
        if self._print_args:
            print('<print> ::', *self._print_args)
            self._print_args = None
        else:
            print('<stdout clear>')

        print('--------------------------')

        digits = int(math.ceil(math.log10(len(self._program))))
        for i, l in enumerate(self._program):
            l = ' ' * 4 + l
            indent_size = len(l) - len(l.lstrip())
            fstr = '{{:{}}}'.format(digits)
            no = fstr.format(str(i + 1))
            if i + 1 == self._previous_line:
                arrow = '-' * (indent_size - 2) + '> '
                l = arrow + l[indent_size:]

            l = no + l
            print(l.rstrip())

    def trace_dispatch(self, frame, event, arg):
        if frame.f_code.co_name == '_print':  # a hack that seems to work okay
            return self.trace_dispatch
        t = super().trace_dispatch(frame, event, arg)
        self._previous_frame = frame
        self._previous_line = frame.f_lineno
        return t

    def user_call(self, frame, args):
        name = frame.f_code.co_name
        lineno = frame.f_lineno
        if not name:
            name = '???'

        self.print_list(frame)
        print('** (line {}) call {}'.format(lineno, name))
        self._wait()

    def user_line(self, frame):
        self.print_list(frame)
        lineno = frame.f_lineno
        print('** (line {})'.format(lineno))
        self._wait()

    def user_return(self, frame, retval):
        self.print_list(frame)
        lineno = frame.f_lineno
        print('** (line {}) returning: {}'.format(lineno, retval))
        self._wait()

    def user_exception(self, frame, exc_stuff):
        self.print_list(frame)
        lineno = frame.f_lineno
        print('** (line {}) exception: {}'.format(lineno, exc_stuff))
        self._wait()
        self.set_continue()

def main(args):
    try:
        scriptName, fName, = args
    except ValueError:
        print('USAGE: trace.py filename')
    else:
        trace(fName)

if __name__ == '__main__':
    main(sys.argv)
