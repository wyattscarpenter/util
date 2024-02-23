#!/usr/bin/env python3
from random import choice
from time import sleep
from sys import argv
"""Frombulate frombulates.

It lets you feel the warm glow of multitasking productivity at all times, even times when you don't really have anything on.

The CPU usage of this program should be especially low.

You may supply additional newline-delimited utf-8 text files to this program (traditionally with the file extension 'fromb') as arguments on the command line. These will then be added to the frombulation array. I didn't see a need for this feature, but my friend requested it. The only file names that cannot be used are the quiet and fast option flags which may be passed to this program."""

the_array = [
  "Installing",
  "Type-checking",
  "Rebuilding cache",
  "Cleaning install directory",
  "Checking",
  "Reserving space",
  "Computing hashes",
  "Checking requirements",
  "Recursing",
  "Computing constraint satisfaction",
  "Model-checking",
  "Waiting on server",
  "Failure! Retrying",
  "Opening",
  "Pre-computing bakes",
  "Initializing",
  "Waiting for pipes to close",
  "Waiting on handle to be freed",
  "Polling hardware",
  "Testing memory integrity",
  "Cleaning",
  "Traversing file system",
  "Caching",
  "Logging error",
  "███████████ | 100%",
  "Surfing subways",
]
args = argv[1:]
if len(args) >=1: print("Using files (and arguments)", args)

def cartesian_string_product(left: list[str], right: list[str]) -> list[str]:
  return [l + r for l in left for r in right]

flag_prefixes = ['-', '--', '/'] #some people don't know this, but the slash is the DOS/cmd flag prefix.
quiet_flag_words = ['q', 'quiet']
fast_flag_words = ['f', 'fast']
quiet_flags = cartesian_string_product(flag_prefixes, quiet_flag_words)
fast_flags = cartesian_string_product(flag_prefixes, fast_flag_words)

quiet = False
fast = False

for filename in args:
  if filename.lower() in quiet_flags:
    quiet = True
  elif filename.lower() in fast_flags:
    fast = True
  else:
    try:
      with open(filename, encoding="utf-8") as f:
        the_array += f.read().split('\n')
    except Exception as e:
      print(e)

print("Frombulating... (Ctrl-C to cancel)")
while True:
  sleep(10 if not fast else .1)
  if not quiet:
    print(choice(the_array),"...",sep="")
