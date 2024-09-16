#bashrc stuff
echo >>~/.bashrc
echo \#Stuff from the script collection Util: >>~/.bashrc
echo . utilrc >>~/.bashrc

#COULD: put this in utilrc, I guess. And, I suppose, do the checks "at runtime", which might simplify the code (perhaps at some small performance cost?)
if grep -qi microsoft /proc/version; then
  echo \#When the script to modify this bashrc was run, I detected the existence of \"Microsoft\", case-insensitive, in the /proc/version, from which I deduce this is a WSL system. >>~/.bashrc
  if [ -d /mnt/wslg/ ] ; then
    echo \#However, when the script to modify this bashrc was run, I detected the existence of /mnt/wslg/, from which I deduce this is a system with WSLg, ie WSL2, ergo I did not need to modify the DISPLAY variable. >>~/.bashrc
  else
    echo \#This next line lets WSL project to an X server running as a Windows application: >>~/.bashrc
    echo export DISPLAY=localhost:0.0 >>~/.bashrc
  fi
else
  : #Non-WSL Linux, no need to do anything. Oh, also the : is a no-op, see https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Bourne-Shell-Builtins
fi

#Makes chmod/chown actually do something (the windows file system won't track executable bits by itself, so you have to tell WSL to track those itself) (TODO: does that mean I should move this up into the previous if statement so it only gets run on WSL systems?).:
echo '[automount]' | sudo tee -a /etc/wsl.conf
echo 'options = "metadata"' | sudo tee -a /etc/wsl.conf

# Ubuntu repository and software stuff: (TODO: I changed the syntax on this but now I'm not sure if this still works or is the recommended way.
sudo add-apt-repository -y main universe restricted multiverse
sudo apt update && sudo apt upgrade && sudo apt autoremove
sudo apt install -y apt-fast
echo "alias get='sudo apt-fast install -y'" >> ~/.bashrc
