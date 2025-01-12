# e tries to open the file in a file *e*xplorer / file browser. It does this first by trying to run the windows file explorer, because I use WSL. Then, it tries xdg-open (and thus, incidentally, e can be used to open all sort of files, really); this should almost always be sufficient, even in WSL. Then, it tries running a smattering of the most-popular(?) linux file explorers.
# Takes one argument, which defaults to . (the working directory). In WSL, Windows File Explorer can't open linux file paths (it doesn't understand them), so just cd to the dir and e there.
# Due to its use of command -v, this command will also print out the path of the executable that it ends up using. This struck me as harmless and potentially informative, so I didn't suppress it.

if command -v explorer.exe; then
  explorer.exe ${1:-.} #incidentally, you can't just check the return code of this explorer.exe command to see if it exists, because on WSL the return code is always 1 https://github.com/microsoft/WSL/issues/6565
elif command -v xdg-open; then
  xdg-open ${1:-.}
elif command -v caja; then
  caja ${1:-.}
elif command -v nautilus; then
  nautilus ${1:-.}
elif command -v dolphin; then
  dolphin ${1:-.}
else
  echo "e could not find a file explorer/browser to open the directory (or other supplied argument) with. Is one registered with XDG for the mime type inode/directory? See https://superuser.com/questions/465495/how-to-find-the-default-file-manager for related information."
fi
