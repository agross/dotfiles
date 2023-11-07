#!/usr/bin/env python3.7

import iterm2
import time

WATCHR = "/usr/local/bin/docker container run --pull=always --rm --tty --volume /Users/agross:/watch:ro ghcr.io/agross/watchr-client"

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
    try:
      watchrTab = await window.async_create_tab('bash', WATCHR)
      await watchrTab.async_set_title('Watchr')
    except Exception as e:
      print(f'Error setting up Watchr: {e}')

    try:
      shellTab = await window.async_create_tab('zsh Trainings', None, 0)
      await shellTab.async_set_title('Git')

      time.sleep(2)

      shellSession = shellTab.current_session
      await shellSession.async_send_text(SHELL_INIT)
    except Exception as e:
      print(f'Error setting up shell: {e}')
  else:
    # You can view this message in the script console.
    print('No current window')

iterm2.run_until_complete(main)
