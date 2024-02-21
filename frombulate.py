#!/usr/bin/env python3
from random import choice
from time import sleep
"""Frombulate frombulates.

It lets you feel the warm glow of multitasking productivity at all times, even times when you don't really have anything on.

The CPU usage of this program should be especially low."""

print("Frombulating... (Ctrl-C to cancel)")
while True:
  sleep(10)
  print(choice(
    [ "Installing",
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
      "Caching"
    ]
  ),"...",sep="")
