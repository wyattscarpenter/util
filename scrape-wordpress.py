#!/usr/bin/env python3

import urllib.request
from bs4 import BeautifulSoup
import sys

CHAPTERS = []

header = """<!doctype html>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
"""
footer = """</body></html>"""

def create_book():
    fp = open("book.html", encoding="utf-8", mode="w")
    fp.write(header)
    fp.write("<main>")
    fp.write("\n\n\n".join(map(str, CHAPTERS)))
    fp.write("</main>")
    fp.write(footer)
    fp.close()

def get_recursively_next(url):
  try:
    global CHAPTERS
    print("Fetching", url, "from web")
    req = urllib.request.Request(
        url, 
        data=None, 
        headers={
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'
        }
    )
    fp = urllib.request.urlopen(req)
    data = fp.read()
    fp.close()

    soup = BeautifulSoup(data, "html.parser")
    content = soup.find_all("article")[0]
    nav = soup.find_all("div", ["pjgm-navigation", "nav-links"])
    prev = None
    next = None
    if nav:
        prevs = nav[0].find_all("a", {"rel": "prev"})
        if prevs: prev = prevs[0].attrs["href"]
        nexts = nav[0].find_all("a", {"rel": "next"})
        if nexts: next = nexts[0].attrs["href"]
    share = soup.find_all("div", "sharedaddy")
    [s.extract() for s in share]
    CHAPTERS.append(content)
    if next: get_recursively_next(next)
  except KeyboardInterrupt:
    print("KeyboardInterrupt! Proceeding with what we have...")

if len(sys.argv) <= 1:
  print("USAGE:", sys.argv[0], "urls...")
  print("Note: The 'next' links of each url will be followed until each is exhausted. The html of each page encountered will be concatenated into a file in your local directory called book.html")
  print("This program is by Wyatt S Carpenter, based on https://github.com/wyattscarpenter/unsong-book-fetcher, which is in turn based on work by Stuart Langridge, to whom much credit is due.")
  print("ebook-convert book.html book.epub #by the way, this will probably do what you want if you want an ebook of the wordpress site and have calibre installed")
else:
  for i in sys.argv[1:]:
    get_recursively_next(i)
  create_book()
