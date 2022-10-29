# .bashrc stuff for WSL X server:
echo #This next line lets WSL project to x server running as a windows application (exe). >> ~/.bashrc
echo export DISPLAY=localhost:0.0 >> ~/.bashrc

# Ubuntu repository and software stuff:
sudo add-apt-repository main
sudo add-apt-repository universe
sudo add-apt-repository restricted
sudo add-apt-repository multiverse
sudo apt update && sudo apt upgrade && sudo apt autoremove
