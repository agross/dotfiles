# no  NORMAL, NORM  Global default, although everything should be something
# fi  FILE  Normal file
# di  DIR Directory
# ln  SYMLINK, LINK, LNK  Symbolic link. If you set this to ‘target’ instead of a numerical value, the color is as for the file pointed to.
# pi  FIFO, PIPE  Named pipe
# do  DOOR  Door
# bd  BLOCK, BLK  Block device
# cd  CHAR, CHR Character device
# or  ORPHAN  Symbolic link pointing to a non-existent file
# so  SOCK  Socket
# su  SETUID  File that is setuid (u+s)
# sg  SETGID  File that is setgid (g+s)
# tw  STICKY_OTHER_WRITABLE Directory that is sticky and other-writable (+t,o+w)
# ow  OTHER_WRITABLE  Directory that is other-writable (o+w) and not sticky
# st  STICKY  Directory with the sticky bit set (+t) and not other-writable
# ex  EXEC  Executable file (i.e. has ‘x’ set in permissions)
# mi  MISSING Non-existent file pointed to by a symbolic link (visible when you type ls -l)
# lc  LEFTCODE, LEFT  Opening terminal code
# rc  RIGHTCODE, RIGHT  Closing terminal code
# ec  ENDCODE, END  Non-filename text
# *.extension   Every file using this extension e.g. *.jpg
#
# The keys (above) are assigned a colour pattern which is a semi-colon separated list of colour codes.
# Effects
# 00  Default colour
# 01  Bold
# 04  Underlined
# 05  Flashing text
# 07  Reversed
# 08  Concealed
# Colours
# 31  Red
# 32  Green
# 33  Orange
# 34  Blue
# 35  Purple
# 36  Cyan
# 37  Grey
# Backgrounds
# 40  Black background
# 41  Red background
# 42  Green background
# 43  Orange background
# 44  Blue background
# 45  Purple background
# 46  Cyan background
# 47  Grey background
# Extra colours
# 90  Dark grey
# 91  Light red
# 92  Light green
# 93  Yellow
# 94  Light blue
# 95  Light purple
# 96  Turquoise
# 97  White
# 100 Dark grey background
# 101 Light red background
# 102 Light green background
# 103 Yellow background
# 104 Light blue background
# 105 Light purple background
# 106 Turquoise background

# Disable oh-my-zsh's LSCOLORS support.
unset LSCOLORS

local executable='00;32'
local archive='00;31'

# Have zsh automatically sync $ls_colors and $LS_COLORS, minus duplicates.
typeset -aUT LS_COLORS ls_colors :

ls_colors=(
  'fi=00'           # fi  FILE  Normal file
  'di=01;34'        # di  DIR Directory
  'ln=00;36'        # ln  SYMLINK, LINK, LNK  Symbolic link. If you set this to ‘target’ instead of a numerical value, the color is as for the file pointed to.
  'pi=40;33'        # pi  FIFO, PIPE  Named pipe
  'so=01;35'        # so  SOCK  Socket
  'do=01;35'        # do  DOOR  Door
  'bd=40;33;01'     # bd  BLOCK, BLK  Block device
  'cd=40;33;01'     # cd  CHAR, CHR Character device
  'or=41;33'        # or  ORPHAN  Symbolic link pointing to a non-existent file
  "ex=$executable"  # ex  EXEC  Executable file (i.e. has ‘x’ set in permissions)

  "*.cmd=$executable"
  "*.exe=$executable"
  "*.com=$executable"
  "*.bat=$executable"
  "*.tar=$archive"
  "*.tbz=$archive"
  "*.tgz=$archive"
  "*.taz=$archive"
  "*.lzh=$archive"
  "*.lzma=$archive"
  "*.zip=$archive"
  "*.7z=$archive"
  "*.z=$archive"
  "*.Z=$archive"
  "*.gz=$archive"
  "*.bz2=$archive"
  "*.tb2=$archive"
  "*.tz2=$archive"
  "*.tbz2=$archive"
)

unset executable
unset archive

export LS_COLORS

# Use colors in file list completion.
zstyle ':completion:*' list-colors $ls_colors
