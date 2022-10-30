#!/usr/bin/env python3.7

import iterm2
import time

WATCHR = "bash -c 'cd ~/gw/watchr/build/bin/Client.Console && Watch__Glob=$HOME/*zsh*.log exec ./Client.Console'"

SHELL_INIT = """open https://agross.github.io/git-reveal/ \\
     'https://drive.explaineverything.com/discover/folders/view-folder?folder.id=1158574' \\
     https://watch.grossweber.com/ ; \\
dnd; \\
nocorrect git training config
"""

async def main(connection):
  app = await iterm2.async_get_app(connection)
  window = app.current_terminal_window

  if window is not None:
    watchrTab = await window.async_create_tab('bash', WATCHR, None)
    await watchrTab.async_set_title('Watchr')

    shellTab = await window.async_create_tab('zsh Trainings', None, 0)
    await shellTab.async_set_title('Git')

    time.sleep(2)

    shellSession = shellTab.current_session
    await shellSession.async_send_text(SHELL_INIT)
  else:
    # You can view this message in the script console.
    print('No current window')

iterm2.run_until_complete(main)
