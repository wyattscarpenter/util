#!/bin/bash

#TODO: maybe this script should just handle one command?

set -a -- my dog #This line sets the command line arguments, and surprisingly is completely POSIX: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#set
echo "$@"

echo CRITICAL ERROR: script is incomplete nocheckin
# exit 1
# I became le tired while writing this script, and other people have already done better jobs than I would: (in order of impressiveness)
https://github.com/ko1nksm/getoptions
https://github.com/moebrowne/bash-argument-parser
https://github.com/akesterson/cmdarg
#Now, if only one of them directly implemented POSIX Utility Argument Syntax https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html
#TODO: maybe just commit and then delete this script tbh? Or master bash cli parsing along the way I guess...

if ! (return 0 2>/dev/null) ; then # This strange condition figures out if we are being sourced, but only works in bash so I might take it out for greater compatibility. See https://stackoverflow.com/a/28776166/20658329
  echo "Error: you have tried to parse some command-line flags using the bash script $0. However, you have called it as a script, when it must be sourced. Use a period before the command."
  exit 1
fi
export FOO=BAR
