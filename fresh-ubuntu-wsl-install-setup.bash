sudo add-apt-repository main
sudo add-apt-repository universe
sudo add-apt-repository restricted
sudo add-apt-repository multiverse
echo #This next line lets WSL project to x server running as a windows application (exe).
echo export DISPLAY=localhost:0.0 >> ~/.bashrc