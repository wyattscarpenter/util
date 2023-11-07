#!/usr/bin/env python3
# This script detects repeated content in a file(s), currently by line.

"""Do I repeat myself? Then I repeat myself! I am large; I contain the same thing multiple times.""" #riffing on a Walt Whitman line

#TODO: test this change to argparse

from collections import defaultdict
import sys
import os
import glob

def eprint(*args, **kwargs):
  print(*args, file=sys.stderr, **kwargs)

debug = False #True

def dprint(*args, **kwargs):
  if debug: eprint(*args, **kwargs)

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('files_to_search_for_repetitions', nargs='+')
args = parser.parse_args()

if len(sys.argv) < 1: # if run with no arguments, this code is self-documenting
  print("USAGE:", sys.argv[0], "files_to_search_for_repetitions...")
  print("IMPLEMENTATION:")
  print(open(__file__).read())
  exit(22)

#must manually glob on windows
files_to_search_for_repetitions = args.files_to_search_for_repetitions
if os.name == "nt":
  for a in sys.argv[1:]:
    globlist = glob.glob(a)
    dprint("glob", a, globlist)
    if globlist:
      files_to_search_for_repetitions +=globlist
    else:
      raise FileNotFoundError(a+" is not a valid file name, nor does it expand to one using (glob) wildcarding.") #could make this just an eprint, if that turns out to be more convenient.
else:
  #files_to_search_for_repetitions = sys.argv[1:]
  pass

d = defaultdict(list)

for filename in files_to_search_for_repetitions:
  print("searching file: ", filename)
  line_number = 1
  with open(filename,"r", encoding="utf8") as file:
    for l in file: #may skip last line of file if you don't have a trailing newline
      d[l] += [filename+":"+str(line_number)]
      line_number += 1
for l in d:
  if len(d[l]) > 1:
    print(d[l])
    print("\t"+l)
