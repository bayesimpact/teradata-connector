# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
# This file is executed automagically at the initialization of Jupyter Notebooks
# get_config() does not need to be imported.

import subprocess
import os
import errno
import stat

c = get_config()
c.NotebookApp.ip = '*'
c.NotebookApp.port = 8888
c.NotebookApp.open_browser = False
