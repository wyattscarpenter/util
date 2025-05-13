#!/usr/bin/env python3
"""A basic command-line calculator, that I mostly use for adding money-formatted strings (which many other calculators reject)."""
from sys import argv
from os import system
args = argv[1:]
if len(args) == 0:
  prompt_mode = True
  system("")
  italic_dollar = "\033[3m $ \033[0m"
  print(italic_dollar, "Welcome to moneyman - enter expressions to evaluate", italic_dollar)
  args = input("> ").split()
else:
  prompt_mode = False
ss = ""
for s in args:
  #could: validate comma spacing in numbers (eg, 3-grouping). This would be culture-specific, but I myself am culture specific.
  ss+=s.replace("$","").replace(",","")
print(ss)
print(eval(ss))
if prompt_mode:
  input("Press any key to exit...")