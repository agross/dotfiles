# dotfiles for my Windows and Cygwin environment

## dotfiles

dotfiles store your personal system settings. These are mine. When compared to Windows' broken registry, dotfiles are bliss.

I mainly use vim, gvim and Git on Cygwin with zsh as my favorite shell. It might be a very special setup, you've been warned.

## install

    git clone git://github.com/agross/dotfiles <somewhere>
    cd <somewhere>
    rake install

The install rake task will symlink the appropriate files in `<somewhere>` to your Cygwin and Windows home directories. You will be asked for the password of an administrative user when the first symlink is created (see next section).

`rake install` will not delete existing files automatically; it will ask you for permission to overwrite files. You can run `rake install` as often as you like, for example after you added new dotfiles.

## configuration

You can configure some settings in `config.yml`:

    admin: <%= ENV['USERDOMAIN']  %>\Administrator
    profiles:
      cygwin: C:\Cygwin\home\<%= ENV['USERNAME'] %>
      windows: <%= ENV['USERPROFILE'] %>
	  
You will be asked for the password of the `admin` user when the first symlink is created. Why? The problem on Windows is that symlinks cannot be created by normal users. `psexec.exe` is used to launch a process that does the symlinking with (hopefully) sufficient administrative permissions.

`profiles.cygwin` and `profiles.windows` denote the respective home directories of the subsystems. The subfolders of `<repository>/profiles/cygwin` and `<repository>/profiles/windows` directly refer to these configuration entries. The contents of the special `<repository>/profiles/all` folder will be symlinked to all `profiles`. If you want a third `profile` entry, just create a new entry in `config.yml` and add a matching folder under `<repository>/profiles`.

## thanks

This work, especially the rakefile, is based on the dotfiles of [Ryan Bates](http://github.com/ryanb/dotfiles) and [Zach Holman](http://github.com/holman/dotfiles).