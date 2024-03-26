#!/usr/bin/env python3
"""Frombulate frombulates.

It lets you feel the warm glow of multitasking productivity at all times, even times when you don't really have anything on.

The CPU usage of this program should be especially low.

You may supply additional newline-delimited utf-8 text files to this program (traditionally with the file extension 'fromb') as arguments on the command line. These will then be added to the frombulation array. I didn't see a need for this feature, but my friend requested it. The only file names that cannot be used are the quiet and fast option flags which may be passed to this program."""
from __future__ import annotations
from random import choice
from time import sleep
from sys import argv

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
  "[###########] 100%",
  "[***********] 256/256",
  "Surfing subways",
]
args = argv[1:]
if len(args) >=1: print("Using files (and arguments)", args)

def cartesian_string_product(left: list[str], right: list[str]) -> list[str]:
  return [l + r for l in left for r in right]

class Strlist(list[str]): #probably not great for a lot of applications, but sure is convenient for this one!
  def __mul__(self, o: Strlist) -> Strlist: return Strlist(cartesian_string_product(self, o)) # type: ignore[override] #mypy would prefer subtyping respect the  Liskov substitution principle, but I don't care about that.

flag_prefixes = Strlist(['-', '--', '/']) #some people don't know this, but the slash is the DOS/cmd flag prefix.
quiet_flag_words = Strlist(['q', 'quiet'])
fast_flag_words = Strlist(['f', 'fast'])
quiet_flags = flag_prefixes*quiet_flag_words
fast_flags = flag_prefixes*fast_flag_words
flag_word_seps = Strlist(["", "-", "_", " "])
fq_flags = flag_prefixes*fast_flag_words*flag_word_seps*quiet_flag_words + flag_prefixes*quiet_flag_words*flag_word_seps*fast_flag_words #this allows for -fq, among other things
help_flags = flag_prefixes*Strlist(['h', 'help', '?', 'info', 'man'])

quiet = False
fast = False

for filename in args:
  if filename.lower() in help_flags:
    print(__doc__, "\n")
    print("quiet_flags", quiet_flags, "Don't print output.", "\n")
    print("fast_flags", fast_flags, "Go fast.", "\n")
    print("fq_flags", fq_flags, "Do both.", "\n")
    print("help_flags", help_flags, "Instead of doing anything else, print this message and then quit.", "\n")
    exit()
  elif filename.lower() in fq_flags:
    fast = True
    quiet = True
  elif filename.lower() in quiet_flags:
    quiet = True
  elif filename.lower() in fast_flags:
    fast = True
  else:
    try:
      with open(filename, encoding="utf-8") as f:
        the_array += f.read().strip('\n').split('\n')
    except Exception as e:
      print(e)

print("Frombulating... (Ctrl-C to cancel)")
while True:
  sleep( 10 if not fast else choice([.01, .05, .1, .15, .2, .25, .3, .5]) )
  if not quiet:
    print(choice(the_array),"...",sep="")
