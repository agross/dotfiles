# dotfiles

dotfiles store your personal settings. These are mine. When compared to Windows' broken registry, dotfiles are bliss.

## Shell

I use [zsh](http://zsh.sourceforge.net/) as my shell, because it's so much better than bash. Want to search your history using wildcards? No problem! Just `bindkey '^R' history-incremental-pattern-search-backward`.

zsh runs on Windows only through Cygwin. Other platforms support it natively through `<package manager> install zsh; chsh --shell /bin/zsh`

Don't expect a fancy bash setup, my dotfiles are organized around zsh.

## Supported Platforms

I use these dotfiles on Windows, Cygwin and Linux. They should work on Mac OS X and msysgit (a.k.a [Git for Windows](https://git-scm.com/download/win)) as well, but I don't use these on a daily basis.

### Cygwin

When you install dotfiles under Cygwin the `bootstrap` script tries to create native NTFS symlinks by `export`ing [`CYGWIN=winsymlinks:nativestrict`](https://cygwin.com/cygwin-ug-net/using.html#pathnames-symlinks)\.

Native NTFS symlinks can only be created if you are either an Administrator [in an elevated shell](http://stackoverflow.com/a/15330511/149264) or if you have the `SeCreateSymbolicLinkPrivilege` privilege. Check with

* `%SystemRoot%\system32\whoami.exe /priv` (`cmd.exe`)
* `$SYSTEMROOT/system32/whoami.exe /priv` (`bash` or `zsh`)

and if necessary [grant yourself this privilege](http://security.stackexchange.com/a/10198).

### msysgit (a.k.a [Git for Windows](https://git-scm.com/download/win))

msysgit's implementation of `ln` just [copies the file/directory to the symlink target](https://groups.google.com/forum/#!topic/msysgit/_0QJUPgLm84).

As I don't use msysgit, I didn't bother working around this limitation. If you're interested in having native NTFS symlinks, you may want to code up a solution that works using [this answer](http://stackoverflow.com/a/25394801/149264) as a starting point and submit a pull request.

## Installation

```bash
$ git clone --recursive https://github.com/agross/dotfiles.git <somewhere>
$ cd <somewhere>
$ ./bootstrap
```

The `bootstrap` script installs dotfiles to your home directory.

The bootstrapper does not delete existing files; it will ask you for permission to overwrite files. Existing files can also be backed up before overwriting. You can run `boostrap` as often as you like, for example after adding new [dotfiles or topics](#structure).

This is what you can expect from the boostrapper on a Linux system:

```
agross@linux ~/.dotfiles
$ ./bootstrap
  [ INFO ] Installing dotfiles from /home/agross/.dotfiles

  [ INFO ] Installing dotfiles to $HOME=/home/agross for $OSTYPE=linux
  [  OK  ] Linked /home/agross/.dotfiles == /home/agross/.dotfiles
  [ INFO ] Running /home/agross/.dotfiles/bash/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/bash/bash_profile.symlink == /home/agross/.bash_profile
  [  OK  ] Linked /home/agross/.dotfiles/bash/bashrc.symlink == /home/agross/.bashrc
  [  OK  ] Linked /home/agross/.dotfiles/bash/inputrc.symlink == /home/agross/.inputrc
  [ INFO ] Running /home/agross/.dotfiles/git/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/git/gitconfig.symlink == /home/agross/.gitconfig
  [  OK  ] Linked /home/agross/.dotfiles/git/gitconfig.training.symlink == /home/agross/.gitconfig.training
  [  OK  ] Linked /home/agross/.dotfiles/git/git-wtfrc.symlink == /home/agross/.git-wtfrc
  [  OK  ] Linked /home/agross/.dotfiles/git/gitshrc.symlink == /home/agross/.gitshrc
  [ INFO ] Running /home/agross/.dotfiles/mintty/bootstrap
  [ INFO ] Running /home/agross/.dotfiles/ruby/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/ruby/gemrc.symlink == /home/agross/.gemrc
  [  OK  ] Linked /home/agross/.dotfiles/ruby/guard.rb.symlink == /home/agross/.guard.rb
  [  OK  ] Linked /home/agross/.dotfiles/ruby/irbrc.symlink == /home/agross/.irbrc
  [  OK  ] Linked /home/agross/.dotfiles/ruby/pryrc.symlink == /home/agross/.pryrc
  [ INFO ] Running /home/agross/.dotfiles/screen/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/screen/screenrc.symlink == /home/agross/.screenrc
  [ INFO ] Running /home/agross/.dotfiles/ssh/bootstrap
  [ INFO ] Running /home/agross/.dotfiles/tmux/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/tmux/tmux.conf.symlink == /home/agross/.tmux.conf
  [ INFO ] Running /home/agross/.dotfiles/vim/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/vim/vim.symlink == /home/agross/.vim
  [  OK  ] Linked /home/agross/.dotfiles/vim/vimrc.symlink == /home/agross/.vimrc
  [ INFO ] Running /home/agross/.dotfiles/wget/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/wget/wgetrc.symlink == /home/agross/.wgetrc
  [ INFO ] Running /home/agross/.dotfiles/zsh/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/zsh/zprofile.symlink == /home/agross/.zprofile
  [  OK  ] Linked /home/agross/.dotfiles/zsh/zshenv.symlink == /home/agross/.zshenv
  [  OK  ] Linked /home/agross/.dotfiles/zsh/zshrc.symlink == /home/agross/.zshrc
  [ INFO ] Running /home/agross/.dotfiles/htop/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/htop/htoprc.symlink == /home/agross/.htoprc
  [ INFO ] Running /home/agross/.dotfiles/elixir/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/elixir/iex.exs.symlink == /home/agross/.iex.exs
  [ INFO ] Running /home/agross/.dotfiles/gpg/bootstrap

  [ INFO ] All installed from /home/agross/.dotfiles
```

## Structure

dotfiles are structured around topics. Topics are directories under the dotfiles root. Each topic directory contains settings specific to the application. This organization allows for a nice separation of concerns. E.g. if you have a new application with dotfile(s) or if the application requires setup in your shell sessions, just create a new topic directory and put files underneath.

```
dotfiles
├─ example
|  ├─ bootstrap              # bootstrapper: script to symlink files and install additional programs
|  ├─ zprofile.zsh           # zsh #1: run for login shells
|  ├─ path.zsh               # zsh #2: modifies $PATH
|  ├─ something.zsh          # zsh #3: additional setup
|  ├─ postinit.zsh           # zsh #4: run after additional setup
|  └─ completion.zsh         # zsh #5: zsh completion setup
└─ git
   ├─ bin                    # contains git scripts
   |  └─ git-specific-script
   ├─ gitconfig.symlink      # symlinked to ~/.gitconfig
   ├─ aliases.zsh            # sets up git aliases
   ├─ path.zsh               # adds dotfiles/git/bin to $PATH
   └─ ...
```

There are some special files that either the `bootstrap` script or [zsh](#shell) reads.

### `bootstrap`-specific files

The bootstrapper will create an implicit symlink for the dotfiles directory itself. It will always be symlinked to `$HOME/.dotfiles` (unless you [`git clone`d the dotfiles](#installation) there.) This makes it easier to refer to other dotfiles from within dotfiles as you can use a static path. For example, [my git mergetool scripts point to `$HOME/.dotfiles/git/tools`](https://github.com/agross/dotfiles/blob/master/git/gitconfig.symlink#L56).

#### topic/bootstrap

`bootstrap` will source each `topic/bootstrap` file and thereby run it using bash. The script can then

* symlink files using the `symlink $source $target` function. `$target` may be omitted, e.g. `symlink foo.symlink` will create the symlink as `$HOME/.foo` pointing to `$DOTFILES/topic/foo.symlink`.
* install additional programs at the script's discretion.

Each `topic/bootstrap` has the following environment variables available:

| Variable  | Description |
| ----------| ----------- |
| `$OSTYPE` | Normalized operating system, e.g. `linux`, `mac`, `windows` for msysgit and Git for Windows, `cygwin`, or the original `$OSTYPE` |
| `$HOME`   | Home directory for the operating system, e.g. `$HOME` for all Linux-style `$OSTYPE`s and `/c/Users/<you>/` for `$OSTYPE == 'windows'` |


### [zsh](#shell)-specific files

I use the excellent [zplug](https://github.com/zplug/zplug) project to manage my zsh plugins and initialization.

You can configure verbose logging of the zsh startup process by [setting `ZSH_VERBOSE`](https://github.com/agross/dotfiles/blob/master/zsh/zshenv.symlink#L4) to a nonempty value.

### topic/\*\*/zprofile.zsh

These files are loaded for login shells only (i.e. `zsh --login`). I use them to [run `screen` or `tmux` when connecting to a server via SSH](https://github.com/agross/dotfiles/blob/master/ssh/zprofile.zsh).

### topic/\*\*/path.zsh

These files are expected to modify the `PATH` environment variable and are loaded before other scripts below are run.

### topic/\*\*/\*.zsh

You can put anything you want in these, e.g. set up topic-specific aliases.

### topic/\*\*/postinit.zsh

Postinit scripts are loaded last, i.e. after all [zplug](https://github.com/zplug/zplug) plugins are loaded and before completion setup is run. Put any last-minute setup here. I use them on Windows to make my Cygwin [SSH agent environment variables known system-wide](https://github.com/agross/dotfiles/blob/master/ssh/postinit.zsh).

### topic/\*\*/completion.zsh

Completion scripts are run after [zplug](https://github.com/zplug/zplug) calls [zsh's `compinit`](http://zsh.sourceforge.net/Doc/Release/Completion-System.html) to initializes the completion system. Put any completion-specific setup here.

Thanks
------

This work, especially the `boostrap` script, is based on the dotfiles of [Zach Holman](http://github.com/holman/dotfiles).

[git-sh](https://github.com/rtomayko/git-sh) by Ryan Tomayko has been adapted to my needs.
