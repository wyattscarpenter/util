#!/bin/bash
[ "$#" -ne 2 ] && echo USAGE: "$0 argument1 argument2" && echo && echo "IMPLEMENTATION:" && cat "$0" && echo && exit 22 #usage message for invalid number of arguments
if cmp "$1" "$2" ; then
  echo 'equal'
  exit 0
else
  echo 'not equal'
  exit 1
fi
