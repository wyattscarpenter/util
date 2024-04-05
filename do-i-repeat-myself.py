#!/usr/bin/env python3
# This script detects repeated content in a file(s), currently by line.

"""Do I repeat myself? Then I repeat myself! I am large; I contain the same thing multiple times.""" #riffing on a Walt Whitman line

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
parser.add_argument('ACTION', help="""The ACTION specifies what the program should do, specifically. The options are:
  REPORT: print a listing of repetitions to standard out.
  KILL: rewrite the file without repetitions.
  QUIET: simply return 1 if there are repetitions and 0 if there aren't, without
  INTERACT: Unimplemented, possible interactive version.
the action specifiers are case-insensitive and in fact only their first letter is used.""")
parser.add_argument('files_to_search_for_repetitions', nargs='+')
parser.add_argument('-sep', '--sep', help="The string to use as a separator in the search. Make sure to quote this properly in your shell when giving it as input! Defaults to a double-newline (\\n\\n, as it were) (I haven't settled on how to deal with python newline system handling yet", default='\n\n')
parser.add_argument('-strategy', help="Presumably I will add several methods of detecting reps at some point", default='split')
parser.add_argument('-ignore_filename_errors', help="normally, passing in an incorrect filename is an error, but said errors can be suppressed", default='naive')


args = parser.parse_args()

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

d = defaultdict(list)
sep = args.sep

for filename in files_to_search_for_repetitions:
  print("searching file: ", filename)
  line_number = 1
  with open(filename,"r", encoding="utf8") as file:
    chunks = file.read().split(sep)
    #input(
    for l in chunks: #may skip last line of file if you don't have a trailing newline
      d[l] += [filename+":"+str(line_number)]
      line_number += 1
for l in d:
  if len(d[l]) > 1:
    print(d[l])
    print("\t"+l)
