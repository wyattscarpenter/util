#!/usr/bin/env python3

import sys
import time
import subprocess
from typing import NoReturn

#!/usr/bin/env python3

help_flags: set[str] = {"-h", "--help", "/?", "-help", "--h"}
no_args_err: int = 22

def main() -> NoReturn:
    if len(sys.argv) < 2 or sys.argv[1] in help_flags:
        print(f"Usage: {sys.argv[0]} <command> [args...]", file=sys.stderr)
        print(f"{sys.argv[0]}, rather like the Unix time command, will run the provided command, print how long it took to stderr, and then exit with the same exit code as the completed process.", file=sys.stderr)
        print(f"{help_flags} or no arguments will cause {sys.argv[0]} to show this message and return with {no_args_err}", file=sys.stderr)
        sys.exit(no_args_err)

    start_time = time.time()
    s = subprocess.run(sys.argv[1:], check=True)
    end_time = time.time()
    elapsed = end_time - start_time
    print(f"\nTime elapsed for {sys.argv[1]} (exited with code {s.returncode}): {elapsed} seconds", file=sys.stderr)
    sys.exit(s.returncode)

if __name__ == "__main__":
    main()
