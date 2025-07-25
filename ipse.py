#!/usr/bin/env python3

# This program parses an ipse file, or series of ipse files, and prints one random pearl of wisdom from them. It's a lot like `fortune` on unix except with a different file format: instead of separating with \n%\n, like in fortune files, ipse files are separated by \n\n (a blank line). \ alone on its own line will be reinterpreted as a blank line. (There is no way to represent a \ on its own line.). The ipse file format is rather adhoc and most ipse files in the world end with .txt instead of .ipse. Files are assumed to be utf-8, probably.
# Like all great programs, this one has a curious name. "Ipse", from the latin phrase "ipse dixit", meaning "he himself said it". "Obiter dicta" ("other things said") would have been a better name for this program, perhaps, but ipse dixit has such a pleasing sound.
# Although there is no way to "weight" the documents, there's nothing that stops you from passing in the name of the same file twice if you want it to be twice as likely to be picked.

# This program was generated (and then modified) from chatgpt (4o mini) using this prompt: python script that reads all the files given as command-line arguments, splits them on \n\n, turns \n\\\n into \n, and picks one of the results randomly. Write as tersely as possible. You are John Carmack btw. add shebang and also if 0 arguments are given print a help message explaining what the program does. Oh also input into stdin counts as a file. use python type annotations on this where appropriate.
# The output of the program was impressive, except that I expected it to work because this is a very basic type of script... and also I subsequently had to edit the script to correct logic errors lol. Still, cool stuff.

import sys
import os
import random
from typing import TextIO
import argparse
import shutil


parser = argparse.ArgumentParser(
    description="""	Ipse reads files, splits on \\n\\n, replaces backslash-only lines with blank lines, and picks one part randomly.
	Stdin counts as a file if the script is used in a pipeline.
	If no arguments are given (and the script is being used interactively (not in a pipeline)), ~/.ipse is used implicitly.
	If directories are passed in as arguments, all files (and directories) within those dirs will be recursively included.""",
)
# These ideas would change the format of ipse too much, but they're kind of cool otherwise:
#  maybe just let the use pass in a [0-9]* as an argument to select a number of output, without a flag?
#  maybe let the splitter of the ipse file be determined by the character before an alphabetical character in a file?
parser.add_argument('ipse_files_and_dirs', nargs="*")
parser.add_argument('-n', '--number', type=int, default=1, help="The number of randomly-selected parts to display. The count of said. How many of them. If negative, an unlimited number will be given, all at once. (Default: 1)")
parser.add_argument('-f', '--filter', type=str, default="", help="If provided, ipse will only return parts that contain the given string as a substring.")
parser.add_argument('-i', '--interactive', action='store_true', help="Interactively view ipses.")
p_args = parser.parse_args()

def process_file(filelike: TextIO) -> list[str]:
    return [ part.replace('\n\\\n', '\n\n').strip() for part in filelike.read().split('\n\n') if part and not part.isspace() if p_args.filter in part ]

parts: list[str] = []
if not sys.stdin.isatty():
    parts.extend(process_file(sys.stdin))
args: list[str] = p_args.ipse_files_and_dirs
if sys.stdin.isatty() and len(args) == 0:
    ipse_default_path = os.path.expanduser("~/.ipse")
    if os.path.exists(ipse_default_path):
        args = [ipse_default_path]
    else:
        exit(f"Ipse was invoked but there were no arguments and {ipse_default_path}, the default location, does not exist.")
for arg in args:
    arg = os.path.expanduser(arg)
    if os.path.isdir(arg):
      args += [ os.path.join(arg, entry) for entry in os.listdir(arg) ]
    else:
      with open(arg) as f:
          parts.extend(process_file(f))

def silly_sample(parts, number):
  return random.sample(parts, number) if number > 0 else parts

def ipse_text() -> str:
  return ('─'*10).join(['\n'*2]*2).join(silly_sample(parts, p_args.number))

def erase_lines(old_text: str|None) -> None:
  """We basically have to do it this way if we want it to behave exactly the way I want.
    There is a bug where if the user adjusts the window enough to displace the cursor backwards then the prompt line prints, the wrong number of lines will be erased (sometimes +/- 1, usually, maybe more idk). How do I fix that? I've already tried using ' \b' instead of just letting the cursor lie at the end of the line. Oh well. It might be a windows terminal bug or something. Not worth fixing. (unless maybe if the arithmetic, which I've lost track of, is wrong.) UPDATE: actually, other apps get wrong cursor behavior sort of like this all the time, so maybe the cmd window is just wrong. Eventually, I will drop "support" for that, I suppose, and remove this comment.
  """
  if old_text is None:
    return
  # Calculate physical lines for old text
  term_width = shutil.get_terminal_size().columns
  old_line_count = sum((len(line) + term_width - 1) // term_width for line in old_text.splitlines()) + 1
  # Move cursor up and clear old text
  print(f"\033[{old_line_count}A\033[0J", end='', flush=True)

if len(parts) == 0:
  exit("Ipse was invoked, with some places it could look, but there are no parts in any of them!")

if not p_args.interactive:
  print(ipse_text())
else:
  os.system("") #enables ansi codes on windows cmd
  history: list[str] = []
  index: int | None = None
  current_display: str | None = None
  while True:
    erase_lines(current_display)
    if index is None:
      t = ipse_text()
      history.append(t)
      index = len(history) - 1
    else:
      t = history[index]
    t += "\n\nq to quit, (p|b|a) for (previous|back|left), (n|f|d) for (next|forward|right), l to list sources, enter for more>"
    inp = input(t).lower()
    current_display = t
    if inp == 'q':
      break
    elif inp in ('p', 'b', 'a'):
      if index is None:
        index = len(history) - 1
      if index > 0:
        index -= 1
    elif inp in ('n', 'f', 'd'):
      if index is not None and index < len(history) - 1:
        index += 1
    elif inp in ('l',):
      for arg in args:
        print(f"{arg}: { 'directory\n' if os.path.isdir(arg) else open(arg).readline()}")
      print("Having successfully printed all the sources and their incipits, I will now exit, to avoid display issues...")
      exit()
    else:
      index = None
