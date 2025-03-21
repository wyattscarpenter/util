This is a collection of small shell scripts I have found useful. Some of them are VERY small, and are only here because I can never remember some particular command.

Each script is documented by comments in the script itself.

This collection pairs well with the wnix collection: https://github.com/wyattscarpenter/wnix/

Some of these scripts have external dependencies; if the script gives you some error about some command not being found, you probably need to go install a dependency. Some common dependencies are imagemagick and ffmpeg.

Most of these scripts were written for Bash on Windows. As far as I can tell, you used to be allowed to invoke an exe from Bash for Windows without its extension, but this was later changed so you have to supply the extension ("command" in the first case vs "command.exe" in the second case). If you have Bash for Windows and you have command.exe but the script is invoking command plain, then try invoking unmark-exe on the exe on the command line (this works if the exe is anywhere on your path). Alternatively, you can install the required software in Bash using apt or similar; however, the packages are often rather out of date (this became a problem for me with ffmpeg).

Some of the scripts assume you're using Ubuntu, or at least apt. `get` in particular. Someone can extend these to other systems if they want.

This collection will probably be the most useful to you if you add this folder to your PATH. The best way for you to do this is to google "how to add directory to path" and then do it yourself. You can also try using the script add-pwd-to-path, but this makes only a half-hearted attempt at doing the right thing.

Once you have this collection on your path, you can then add . utilrc to your bashrc to get the customizations and aliases from utilrc. The fresh-ubuntu-wsl-install-setup.bash script will also do this for you, among other things.

I consider (many of) these scripts too trivial to fall under copyright. However, I am not a lawyer, so if I do actually hold a copyright on these scripts, I release them into the public domain under CC0. See https://creativecommons.org/publicdomain/zero/1.0/ for more information. Some (almost none) of these scripts were written by other people, so I claim no ownership over those. See the comments for details about these; usually my scripts were just inspired (in the sense of art inspiring other art to use a similar structure or elements) by other scripts, and I note this appropriately, and they are still my original creations. However, sometimes I have just copied someone else's script wholesale, and have noted that appropriately.

The name of this collection is a small joke, as "util" is generally regarded by programmers to be a terribly uninformative name for anything. This collection is dedicated to Jeremy Bentham, the inventor of usefulness.

Most scripts begin with some variation of the following header:

```
#!/bin/bash
set -euo pipefail #bash strict mode
[ "$#" -eq 0 ] && echo USAGE: "$0 arguments..." && echo && echo "IMPLEMENTATION:" && cat "$0" && echo && exit 22 #usage message for invalid number of arguments
```

The usage message from which shall (hopefully) conform to the POSIX Utility Argument Syntax format ( see here: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html )

Sometimes I think about automating the argument validation, and then I remember that other people have written fully-featured libraries/functions that do this, that I chose not to use just because I found them slightly unwieldy. If I were to automate validation, though, I think I would want to pass in a posix utility argument syntax format string (plus executable name and actual arguments) and have that other script either crash or proceed me. Of course, then you start thinking about how to provide the help messages...

It seems like EINVAL ("Invalid argument") is a useful return value for exit to pass in this case, and EINVAL is 22 on my system, but empirically other programs like whereis and printf return random error codes like 1 or 2. Also, I am extremely inconsistent in whether I have actually harmonized any of this stuff.

Typically you can find out what a script does by typing it with no arguments. However, this is technically unsafe, in that it doesn't always work, so you should actually use the text command to print the text of the command instead. Some scripts, for example pathn, just don't need any arguments! Additionally, some scripts take 0 arguments and operate on the current directory, which is probably a bad idea so I may fix them some day. (Todo: have I gotten all these? I mean, of course, except add-pwd-to-path

The way I currently think about it, if a script takes any arguments, it should have the header, and when run with no arguments should print out its help message. However, some scripts take no arguments and are best thought of as shortcuts invoking longer scripts. You must use the `text` command from this collection to see their interiors, as running them without arguments will just run them. There should be as few of those latter as possible, but some definitely still strike me as requiring that form factor (unless I just required the user to pass in a flag to confirm they know what they're doing? Hmm...). Also, some scripts are missing the header just because I haven't put it in yet haha.

Some linting tools you can run on these files, at least the bash/sh scripts: shellcheck, checkbashisms (this latter one allowing you to achieve rarefied pure-sh status, which, uh maybe means your scripts will execute slightly faster sometimes. And can run on the systems of hypothetical people who don't have bash these days).

Currently, all of my scripts (although, see again the caveat about how harmonization is inconsistent) have the executable bit set, because you're supposed to be able to execute all of them. However, I've never been sure if you're supposed to set that bit for, eg, a Windows batch file. After all, Unix can't execute that file — which is perhaps what the execute bit is supposed to indicate — and Windows doesn't honor the bit anyway. I couldn't really figure out the canonical answer to this question, except that in practice most people ignore the executable bit anyway unless it makes problems for them in trying to execute scripts/executables after clone.
