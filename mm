#!/bin/bash
set -euo pipefail #bash strict mode
[ "$#" -lt 1 ] && echo USAGE: "$0 music_files_or_dirs_to_copy_and_convert..." && echo && echo "IMPLEMENTATION:" && cat "$0" && echo && exit 22 #usage message for invalid number of arguments

populate-mmusic-dir "mm" "$@"
