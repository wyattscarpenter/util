#!/usr/bin/env python3
# Written by ChatGPT.
import json
from sys import argv

def extract_leaves(obj, path=()):
    leaves = set()

    if isinstance(obj, dict):
        for k, v in obj.items():
            leaves.update(extract_leaves(v, path + (k,)))
    elif isinstance(obj, list):
        for i, item in enumerate(obj):
            leaves.update(extract_leaves(item, path + (i,)))
    else:
        # terminal key-value pair
        leaves.add((path, obj))

    return leaves


def compare_json(file1, file2):
    # A little human touch here. I don't know why this was giving me UnicodeDecodeErrors before, on my UTF-8 files...
    with open(file1, errors='surrogateescape') as f:
        data1 = json.load(f)
    with open(file2, errors='surrogateescape') as f:
        data2 = json.load(f)

    leaves1 = extract_leaves(data1)
    leaves2 = extract_leaves(data2)

    missing = leaves1 - leaves2

    if not missing:
        print("All terminal key-value pairs from file1 are present in file2. 1<=2. 1 \ 2 = {}. 1-2=0.")
        # The annoying rephrases here are also my human touch.
    else:
        print("Missing terminal key-value pairs:")
        for path, value in sorted(missing):
            print(f"{'.'.join(map(str, path))} = {value}")


if __name__ == "__main__":
    compare_json(argv[1], argv[2])
