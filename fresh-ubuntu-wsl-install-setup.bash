#bashrc stuff
echo >>~/.bashrc
echo \#Stuff from the script collection Util: >>~/.bashrc
echo . utilrc >>~/.bashrc

if grep -qi microsoft /proc/version; then
  echo \#When the script to modify this bashrc was run, I detected the existence of \"Microsoft\", case-insensitive, in the /proc/version, from which I deduce this is a WSL system. >>~/.bashrc

  #Makes chmod/chown actually do something (the windows file system won't track executable bits by itself, so you have to tell WSL to track those itself)
  echo '[automount]' | sudo tee -a /etc/wsl.conf
  echo 'options = "metadata"' | sudo tee -a /etc/wsl.conf

  if [ -d /mnt/wslg/ ] ; then
    echo \#When the script to modify this bashrc was run, I detected the existence of /mnt/wslg/, from which I deduce this is a system with WSLg, ie WSL2, ergo I did not need to modify the DISPLAY variable. >>~/.bashrc
  else
    echo \#This next line lets WSL project to an X server running as a Windows application: >>~/.bashrc
    echo export DISPLAY=localhost:0.0 >>~/.bashrc
  fi
else
  : #Non-WSL Linux, no need to do anything. Oh, also the : is a no-op, see https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Bourne-Shell-Builtins
fi

# Ubuntu repository and software stuff:
sudo add-apt-repository -y main universe restricted multiverse ppa:apt-fast/stable
sudo apt update && sudo apt upgrade && sudo apt autoremove
sudo apt install -y apt-fast git-extras

# This gets gyatt for you, and installs it (uses && so that we can bail out if the folder already exists and therefore we've already done it.
git clone https://github.com/wyattscarpenter/gyatt ../ && cd ../gyatt && . install_pwd_to_git.sh
