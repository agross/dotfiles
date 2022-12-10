# dotfiles

dotfiles store your personal settings. These are mine. When compared to Windows'
broken registry, dotfiles are bliss.

## Shell

I use [zsh](http://zsh.sourceforge.net/) as my shell, because it's so much
better than bash. Want to search your history using wildcards? No problem! Just
`bindkey '^R' history-incremental-pattern-search-backward`.

zsh runs on Windows only through Cygwin. Other platforms support it natively
through `<package manager> install zsh; chsh --shell $(which zsh)`

Don't expect a fancy bash setup, my dotfiles are organized around zsh.

## Supported Platforms

I use these dotfiles on Windows, Cygwin, macOS and Linux. They should work on
msysgit (a.k.a. [Git for Windows](https://git-scm.com/download/win)) as well,
but I don't use it on a daily basis.

### Cygwin

When you install dotfiles under Cygwin the `bootstrap` script tries to create
native NTFS symlinks by running `ln` with
[`CYGWIN=winsymlinks:nativestrict`](https://cygwin.com/cygwin-ug-net/using.html#pathnames-symlinks).

Native NTFS symlinks can only be created if you are either an Administrator
[in an elevated shell](http://stackoverflow.com/a/15330511/149264) or if you
have the `SeCreateSymbolicLinkPrivilege` privilege. Check with

* `%SystemRoot%\system32\whoami.exe /priv` (`cmd.exe`)
* `$SYSTEMROOT/system32/whoami.exe /priv` (`bash` or `zsh`)

and if necessary [grant yourself this privilege](http://security.stackexchange.com/a/10198).

### msysgit (a.k.a. [Git for Windows](https://git-scm.com/download/win))

msysgit's implementation of `ln` just
[copies the file/directory to the symlink target](https://groups.google.com/forum/#!topic/msysgit/_0QJUPgLm84).

As I don't use msysgit, I didn't bother working around this limitation. If
you're interested in having native NTFS symlinks, you may want to code up a
solution that works using
[this answer](http://stackoverflow.com/a/25394801/149264) as a starting point
and submit a pull request.

## Installation

```bash
$ git clone --recursive https://github.com/agross/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./bootstrap
```

The `bootstrap` script installs (symlinks) dotfiles to your home directory.

The bootstrapper does not delete existing files; it will ask you for permission
to overwrite files. Existing files can also be backed up before overwriting.
You can run `boostrap` as often as you like, for example after adding new
[dotfiles or topics](#structure).

This is what you can expect from the boostrapper on a Linux system:

```
agross@linux ~/.dotfiles
$ ./bootstrap
  [ INFO ] Installing dotfiles from /home/agross/.dotfiles

  [ INFO ] Installing dotfiles to $HOME=/home/agross for $OSTYPE=linux
  [  OK  ] Linked /home/agross/.dotfiles == /home/agross/.dotfiles
  [ INFO ] Running /home/agross/.dotfiles/bash/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/bash/bash_profile == /home/agross/.bash_profile
  [  OK  ] Linked /home/agross/.dotfiles/bash/bashrc == /home/agross/.bashrc
  [  OK  ] Linked /home/agross/.dotfiles/bash/inputrc == /home/agross/.inputrc
  [ INFO ] Running /home/agross/.dotfiles/git/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/git/gitconfig == /home/agross/.gitconfig
  [  OK  ] Linked /home/agross/.dotfiles/git/gitconfig.training == /home/agross/.gitconfig.training
  [  OK  ] Linked /home/agross/.dotfiles/git/git-wtfrc == /home/agross/.git-wtfrc
  [  OK  ] Linked /home/agross/.dotfiles/git/gitshrc == /home/agross/.gitshrc
  [ INFO ] Running /home/agross/.dotfiles/mintty/bootstrap
  [ INFO ] Running /home/agross/.dotfiles/ruby/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/ruby/gemrc == /home/agross/.gemrc
  [  OK  ] Linked /home/agross/.dotfiles/ruby/guard.rb == /home/agross/.guard.rb
  [  OK  ] Linked /home/agross/.dotfiles/ruby/irbrc == /home/agross/.irbrc
  [  OK  ] Linked /home/agross/.dotfiles/ruby/pryrc == /home/agross/.pryrc
  [ INFO ] Running /home/agross/.dotfiles/screen/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/screen/screenrc == /home/agross/.screenrc
  [ INFO ] Running /home/agross/.dotfiles/ssh/bootstrap
  [ INFO ] Running /home/agross/.dotfiles/tmux/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/tmux/tmux.conf == /home/agross/.tmux.conf
  [ INFO ] Running /home/agross/.dotfiles/vim/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/vim/vim == /home/agross/.vim
  [  OK  ] Linked /home/agross/.dotfiles/vim/vimrc == /home/agross/.vimrc
  [ INFO ] Running /home/agross/.dotfiles/wget/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/wget/wgetrc == /home/agross/.wgetrc
  [ INFO ] Running /home/agross/.dotfiles/zsh/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/zsh/zprofile == /home/agross/.zprofile
  [  OK  ] Linked /home/agross/.dotfiles/zsh/zshenv == /home/agross/.zshenv
  [  OK  ] Linked /home/agross/.dotfiles/zsh/zshrc == /home/agross/.zshrc
  [ INFO ] Running /home/agross/.dotfiles/htop/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/htop/htoprc == /home/agross/.htoprc
  [ INFO ] Running /home/agross/.dotfiles/elixir/bootstrap
  [  OK  ] Linked /home/agross/.dotfiles/elixir/iex.exs == /home/agross/.iex.exs
  [ INFO ] Running /home/agross/.dotfiles/gpg/bootstrap

  [ INFO ] All installed from /home/agross/.dotfiles
```

## Structure

dotfiles are structured around topics. Topics are directories under the dotfiles
root. Each topic directory contains settings specific to the application. This
organization allows for a nice separation of concerns. E.g. if you have a new
application with dotfile(s) or if the application requires setup in your shell
sessions, just create a new topic directory and put files underneath.

```
dotfiles
├─ example
|  ├─ bootstrap              # bootstrapper: script to symlink files and install additional programs
|  ├─ zshenv.zsh             # zsh #1: run for all shells
|  ├─ zprofile.zsh           # zsh #2: run for login shells
|  ├─ fpath.zsh              # zsh #3: set up the $FPATH variable
|  ├─ path.zsh               # zsh #3: set up the $PATH variable
|  ├─ something.zsh          # zsh #4: additional setup (no guaranteed order)
|  └─ completion.zsh         # zsh #5: zsh completion setup
└─ git
   ├─ bin                    # contains git scripts, invoke with `git specific-script`
   |  └─ git-specific-script
   ├─ bootstrap              # bootstrapper to create symlinks
   ├─ gitconfig              # symlinked to ~/.gitconfig by bootstrap
   ├─ aliases.zsh            # sets up git aliases
   ├─ path.zsh               # adds dotfiles/git/bin to $PATH
   └─ ...
```

There are some special files that either the `bootstrap` script or
[zsh](#shell) reads.

### The `bootstrap`per

The bootstrapper will create an implicit symlink for the dotfiles directory
itself. `$HOME/.dotfiles` will point to the dotfiles clone directory unless you
[`git clone`d the dotfiles](#installation) into `$HOME/.dotfiles`.

This makes it easier to refer to other dotfiles from within dotfiles as you can
use a static path. For example, [my `git mergetool` scripts point to
`$HOME/.dotfiles/git/tools`](https://github.com/agross/dotfiles/blob/master/git/git-mergetools#L2).

#### topic/bootstrap

`bootstrap` will run topic-specific `topic/bootstrap` scripts where `topic` is one
of the top-level subdirectories like `git`. These scripts can then

* symlink files using the [`symlink $source $target`](https://github.com/agross/dotfiles/blob/master/bootstrap#L71)
  function. `$target` may be omitted, e.g. `symlink $topic/foo` will create the
  symlink as `$HOME/.foo` pointing to `$DOTFILES/topic/foo`.
* install additional programs at the script's discretion.

Each `topic/bootstrap` runs in a separate shell and has the following
environment variables available:

| Variable    | Description |
| ------------| ----------- |
| `$topic`    | Directory of the topic of the current `bootstrap` script (without trailing slash) |
| `$OSTYPE  ` | Operating system type, e.g. `linux-gnu`, `darwin19.0.3`, `cygwin`, i.e. the original `$OSTYPE` |
| `$HOME`     | Home directory for the operating system, e.g. `$HOME` for all Linux-style `$OSTYPE`s and `/c/Users/<you>/` for `$OSTYPE == 'windows'` |

### [zsh](#shell)-specific files

I use [zinit](https://github.com/zdharma-continuum/zinit) to manage my zsh
plugins and shell initialization.

You can configure verbose logging of the zsh startup process by
[setting `ZSH_VERBOSE`](https://github.com/agross/dotfiles/blob/master/zsh/zshenv#L4)
to a nonempty value.

#### topic/\*\*/zshenv.zsh and topic/\*\*/zprofile.zsh

`zshenv.zsh` files are loaded for every shell. Make sure they load fast.

`zprofile.zsh` files are loaded for login shells only (i.e. `zsh --login`).
I use them to [run `screen` or `tmux` when connecting to a server via SSH](https://github.com/agross/dotfiles/blob/master/ssh/zprofile.zsh).

[Documentation on startup files.](https://zsh.sourceforge.io/Intro/intro_3.html)

#### topic/\*\*/fpath.zsh and topic/\*\*/path.zsh

Add to the `$FPATH` (function path) and `$PATH` (binary path) variables here so
later scripts (next section) can find your topic-specific functions and
executables.

#### topic/\*\*/\*.zsh

You can put anything you want in these, e.g. set up topic-specific aliases.

#### topic/\*\*/completion.zsh

Completion scripts are run after [zinit](https://github.com/zdharma-continuum/zinit)
calls [zsh's `compinit`](http://zsh.sourceforge.net/Doc/Release/Completion-System.html)
to initialize the completion system. Put any completion-specific setup here.

# Thanks

This work, especially the `boostrap` script, is based on the dotfiles of
[Zach Holman](http://github.com/holman/dotfiles).

[git-sh](https://github.com/rtomayko/git-sh) by Ryan Tomayko has been adapted to
my needs.
