#!/usr/bin/env python3
#should print out chapters for mp4s, m4bs, mkvs, etc, etc... into a file called chapters.whatever.txt, and also on the command line
import subprocess
import json
import sys
import inspect
from math import floor

if len(sys.argv) < 2: # if run with no arguments, this code is self-documenting
  print("USAGE:", sys.argv[0], "files...")
  print("IMPLEMENTATION:")
  print(open(__file__).read())
  exit(22)
for i in sys.argv[1:]:
  print(i)
    #  out = subprocess.run(["ffprobe", "-i", i, "-print_format", "json", "-show_chapters", "-loglevel", "quiet"], capture_output=True).stdout #this is how you do it in python 3.7 and later I guess

  output=subprocess.check_output(["ffprobe", "-i", i, "-print_format", "json", "-show_chapters", "-loglevel", "fatal"])
  d = json.loads(output)
  print("\v")
  with open('chapters.'+i+'.txt', 'w') as f: #clear file for new writing
      f.write("")
  for c in d["chapters"]:
    #first we parse the time... I should have just used the -sexagesimal flag instead...
    seconds = floor(float(c["start_time"]))
    timestr = str(seconds//(60*60)).zfill(2)+":"+str(seconds%(60*60)//60).zfill(2)+":"+str(seconds%60).zfill(2)
    with open('chapters.'+i+'.txt', 'a') as f:
      f.write(timestr+" "+ c["tags"]["title"]+"\n")
    print(timestr, c["tags"]["title"])
  #print(out.decode("utf-8"))
