#!/bin/sh

/c/Tools/Sublime\ Text/subl.exe --wait --new-window "$(cygpath --windows --absolute "$@")"
