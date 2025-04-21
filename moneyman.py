#!/usr/bin/env python3
"""A basic command-line calculator, that I mostly use for adding money-formatted strings (which many other calculators reject)."""
from sys import argv
ss = ""
for s in argv[1:]:
  #could: validate comma spacing in numbers (eg, 3-grouping). This would be culture-specific, but I myself am culture specific.
  ss+=s.replace("$","").replace(",","")
print(ss)
print(eval(ss))
