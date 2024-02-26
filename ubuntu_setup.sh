#!/bin/sh
#
# Installs various software for Ubuntu 22.04 LTS with GPU.
# Make the script executable
#  	chmod +x ubuntu_setup.sh
# Run:
#   sudo ./ubuntu_setup.sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Ensure the script is executed with superuser privileges
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


sudo apt update
sudo apt upgrade

sudo apt-get install linux-headers-$(uname -r)
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo apt-get install -y wget
sudo apt-get install -y geany
sudo apt-get install -y gcc


echo "Installing browsers ..."
sudo apt install -y firefox
sudo apt install -y brave-browser

echo "Downloading and installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt-get -f install -y

echo "Installing Tor browser from Snap ..."
sudo snap install tor-browser

echo "Installing PyCharm Community Edition ..."
sudo snap install pycharm-community --classic

echo "Installing Blender ..."
sudo apt install -y blender

echo "Installing utilities ..."
sudo apt-get install -y vlc meshlab cheese qbittorrent

# Install Zoom
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo dpkg -i zoom_amd64.deb
sudo apt-get install -f

# Install Slack (Snap package)
sudo snap install slack --classic

# Install Obsidian (Snap package)
sudo snap install obsidian --classic


# Install Dropbox and start it 
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd &

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install -y docker-ce

# Docker post-installation steps (optional)
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 


# Installing NVidia's software:
# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#ubuntu
# Install CUDA SDK:
sudo apt-get install cuda-toolkit
# To include all GDS packages:
sudo apt-get install nvidia-gds
#need reboot and manual configuaritions. See a separate nvidia_install.sh (TODO)

# For applications requiring manual setup or download from their websites:
echo "Please visit the official websites to download and install NordVPN, MuJoCo, Beyond Compare, XMind and Pomatez."

echo "Setup completed successfully!"
echo "TODO manually: enable Ubuntu Pro"
