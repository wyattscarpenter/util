# E tries to open the file in a file *e*xplorer / file browser. It does this first by trying to run xdg-open (and thus, incidentally, e can be used to open all sort of files, really); this should almost always be sufficient, even in WSL. Then, it tries running the windows file explorer. Then, it tries running a smattering of the most-popular(?) linux file explorers.
# Takes one argument, which defaults to . (the working directory).

if `command -v xdg-open`; then
  xdg-open ${1:-.}
elif `command -v explorer.exe` ; then
  explorer.exe ${1:-.} #incidentally, you can't just check the return code of this explorer.exe command to see if it exists, because on WSL the return code is always 1 https://github.com/microsoft/WSL/issues/6565
elif `command -v caja`
  caja ${1:-.}
elif `command -v nautilus`
  nautilus ${1:-.}
elif `command -v dolphin`
  dolphin ${1:-.}
else
  echo "E could not find a file explorer/browser. Is one registered with XDG for the mime type inode/directory? See https://superuser.com/questions/465495/how-to-find-the-default-file-manager for related information."
fi
