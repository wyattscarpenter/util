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
  #Non-WSL Linux, no need to do anything
fi

#Makes chmod/chown actually do something (the windows file system won't track executable bits by itself, so you have to tell WSL to track those itself) (TODO: does that mean I should move this up into the previous if statement so it only gets run on WSL systems?).:
#You need to be root to do these things, but it's not quite clear to me how it is to be done without interrupting itself.
#sudo -s #this just entered a root shell and did nothing, so I guess I'll try tee #note: I guess it worked but I don't remember.
echo '[automount]' | sudo tee -a /etc/wsl.conf
echo 'options = "metadata"' | sudo tee -a /etc/wsl.conf

# Ubuntu repository and software stuff:
sudo add-apt-repository main
sudo add-apt-repository universe
sudo add-apt-repository restricted
sudo add-apt-repository multiverse
sudo apt update && sudo apt upgrade && sudo apt autoremove
