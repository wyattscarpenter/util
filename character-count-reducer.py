#!/usr/bin/env python3

def eprint(*args, **kwargs):
  print(*args, file=sys.stderr, **kwargs)

debug = False #True

def dprint(*args, **kwargs):
  if debug: eprint(*args, **kwargs)

s = re.sub(r"\band\b", "&", s)
s = re.sub(r"\bat\b", "@", s)


s = re.sub(r"\bone\b", "1", s)
#s = re.sub(r"\bones\b", "1s", s) #doesn't work, for my particular purpose
s = re.sub(r"\bwon\b", "1", s)
s = re.sub(r"\bfirst\b", "1st", s)

s = re.sub(r"\bfor\b", "4", s)

s = re.sub(r"\bthe\b", "þ", s)
s = re.sub(r"\bthere\b", "þr", s)
s = re.sub(r"\btheir\b", "þr", s)
s = re.sub(r"\bthey're\b", "þr", s)

s = re.sub(r"th", "þ", s) # this is a risky one because of compound word boundaries like rathide or whatever. Also where the th just means an aspirated t.
s = re.sub(r"ng", "ŋ", s) # 〃

#technically I could remove all spaces around punctuation but I'm not sure how to do this
