#!/usr/bin/env python3
# This script renames files to slightly-cleaned-up OCR of those files. I doubt it will be perfect, so proofread!
# This script is primarily intended to have files dragged to it in the desktop, but it will also work on the command line.
# Fun fact: This is a batch script, redone in python just to escape terrible batch quoting (etc) land.

import traceback
import sys
import subprocess
import re
import os
import glob

def eprint(*args, **kwargs):
  print(*args, file=sys.stderr, **kwargs)

debug = False #True

def dprint(*args, **kwargs):
  if debug: eprint(*args, **kwargs)

try:
  if len(sys.argv) < 2: # if run with no arguments, this code is self-documenting
    print("USAGE:", sys.argv[0], "files_to_rename_to_ocrs_of_themselves...")
    print("IMPLEMENTATION:")
    print(open(__file__).read())
    exit(22)
  
  #must manually glob on windows
  files_to_rename_to_ocrs_of_themselves = []
  if os.name == "nt": 
    for a in sys.argv[1:]:
      globlist = glob.glob(a)
      if globlist:
        files_to_rename_to_ocrs_of_themselves +=globlist
      else:
        raise FileNotFoundError(a+" is not a valid file name, nor does it expand to one using (glob) wildcarding.") #could make this just an eprint, if that turns out to be more convenient.
  else:
    files_to_rename_to_ocrs_of_themselves = sys.argv[1:]

  for i in files_to_rename_to_ocrs_of_themselves:
    print("filename: ", i)
    if not i: continue
    dprint(glob.glob(i))
    #  out = subprocess.run([], capture_output=True).stdout #this is how you do it in python 3.7 and later I guess

    output=subprocess.check_output(["tesseract", i, "stdout", "--psm", "1"]) #technically, I could also use outputbase instead of stdout to store this into a file instead of monkeying around with stdout, but that's also less clean, in a way.
    dprint("raw: ", output)
    output = output.decode("utf-8")
    dprint("utf-8: ", output)
    output = re.sub(r"\|", "I", output) #for some reason it often gets these wrong
    output = output.lower()
    dprint("lowered: ", output)
    output = re.sub(r"[^\w\s]", "", output)
    dprint("sub out non-word: ", output)
    output = re.sub(r"\s+", " ", output).strip()
    dprint("sub out spaces: ", output)
    dirname = os.path.dirname(i)
    ext = os.path.splitext(i)[1] #this is "split ext(ention)", not "split text", btw.
    output = output[0:255-len(ext)-1] #limit name to make operating system happy #the -1 is for good luck! or, possibly, the trailing nul that other systems (file explorer, perhaps) occasionally must slap on there.
    output = os.path.join(dirname, output+ext) #we could just dirname+"/"+output+ext, but I've elected to use the fancy way.
    print(output)
    os.rename(i, output)
    if debug: input() #pause to let user read debug messages
except Exception as e:
  print(e)
  print(traceback.format_exc())
  input() #pause to let user read error message
