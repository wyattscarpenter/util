#bashrc stuff
echo >>~/.bashrc
echo \#Stuff from the script collection Util: >>~/.bashrc
echo \#This next line lets WSL project to an X server running as a windows application (exe): >>~/.bashrc
echo export DISPLAY=localhost:0.0 >>~/.bashrc
#This lets you exit the shell with the pseudo-command "q"
alias-q-exit
#Make bash command prompt always show the status returned by the previously-run command
make-bash-prompt-show-status
echo >>~/.bashrc

#Makes chmod/chown actually do something:
#sudo zone I guess!
sudo -s #the below don't work with regular sudo, although you could use tee instead.
sudo echo [automount] >>/etc/wsl.conf
sudo echo options = "metadata" >>/etc/wsl.conf

# Ubuntu repository and software stuff:
sudo add-apt-repository main
sudo add-apt-repository universe
sudo add-apt-repository restricted
sudo add-apt-repository multiverse
sudo apt update && sudo apt upgrade && sudo apt autoremove
