#!/bin/bash
#set -euo pipefail #no bash strict mode, because I'm pretty sure the arithmetic triggers a pipefail sometimes when I turn this on. 
[ "$#" -eq 0 ] && echo USAGE: "$0 numerator divisors..." && echo && echo "IMPLEMENTATION:" && cat "$0" && echo && exit 22 #usage message for invalid number of arguments
acc="$1"
shift
[ "$#" -eq 0 ] && echo $((1%acc)) && exit
for i in "$@"; do
  ((acc%=i))
done
echo $acc