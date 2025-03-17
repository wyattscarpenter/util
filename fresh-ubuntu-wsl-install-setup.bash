# This script is especially likely to have bugs, be unoptimized, etc, since I only run it about once a year or whatever. And it interacts with so many incompatible bits of infrastructure.

#bashrc stuff
echo >>~/.bashrc
echo \#Stuff from the script collection Util: >>~/.bashrc
echo . utilrc >>~/.bashrc

# Ubuntu repository and software stuff:
sudo add-apt-repository -y main universe restricted multiverse
sudo add-apt-repository -y ppa:apt-fast/stable # For whatever reason, this has to be on its own line.
sudo apt install -y apt-fast # do this first to go faster :rollsafe:
sudo apt-fast update && sudo apt-fast upgrade -y && sudo apt-fast autoremove -y
sudo apt-fast install -y git-extras make python-is-python3 python3-pip
sudo snap install --classic astral-uv # Instead of this you could do pip install --break-system-packages uv

if grep -qi microsoft /proc/version; then
  echo \#  When the script to modify this bashrc was run, I detected the existence of \"Microsoft\", case-insensitive, in the /proc/version, from which I deduce this is a WSL system. >>~/.bashrc

  #Makes chmod/chown actually do something (the windows file system won't track executable bits by itself, so you have to tell WSL to track those itself)
  echo '[automount]' | sudo tee -a /etc/wsl.conf
  echo 'options = "metadata"' | sudo tee -a /etc/wsl.conf

  if [ -d /mnt/wslg/ ] ; then
    echo \#  Furhtermore, When the script to modify this bashrc was run, I detected the existence of /mnt/wslg/, from which I deduce this is a system with WSLg, ie WSL2, ergo I did not need to modify the DISPLAY variable. >>~/.bashrc
  else
    echo \# This next line lets WSL project to an X server running as a Windows application: >>~/.bashrc
    echo export DISPLAY=localhost:0.0 >>~/.bashrc
  fi
else
  : #Non-WSL Linux, no need to do anything related to WSL. Oh, also the : is a no-op, see https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Bourne-Shell-Builtins
  echo Non-WSL Ubuntu? Let me install gyatt for you
  # This gets gyatt for you, and installs it (uses && so that we can bail out if the folder already exists and therefore we've already done it.
  git clone https://github.com/wyattscarpenter/gyatt ../ && cd ../gyatt && . install_pwd_to_git.sh
fi