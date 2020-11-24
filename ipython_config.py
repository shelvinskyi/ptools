# Configuration file for ipython.

# preload
c.InteractiveShellApp.hide_initial_ns = False
c.InteractiveShellApp.exec_lines = [
    'import pandas as pd',
    'import numpy as np',
    'import torch',
    'import os',
    'import json',
    'import sys',
    'import re',
    'from collections import Counter, defaultdict',
    'from datetime import datetime',
    'from uuid import uuid4'
]

# cosmetics
c.InteractiveShell.colors = 'Neutral' ## NoColor, Neutral, Linux, LightBG
c.InteractiveShell.history_length = 10000
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.editing_mode = 'emacs' # vi, emacs
c.TerminalInteractiveShell.editor = 'vim'
c.TerminalInteractiveShell.term_title = True
c.TerminalInteractiveShell.term_title_format = 'ipython'

# other interesting stuff
# c.InteractiveShell.quiet = False
# c.InteractiveShellApp.exec_files = []
# c.InteractiveShellApp.code_to_run = ''
# c.InteractiveShellApp.extensions = []
# c.InteractiveShellApp.extra_extension = ''
# c.InteractiveShellApp.matplotlib = None

## Enable GUI event loop integration with any of ('asyncio', 'glut', 'gtk',
#  'gtk2', 'gtk3', 'osx', 'pyglet', 'qt', 'qt4', 'qt5', 'tk', 'wx', 'gtk2',
#  'qt4').
# c.InteractiveShellApp.gui = None
