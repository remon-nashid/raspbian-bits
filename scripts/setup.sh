#!/usr/bin/env bash

#####################
# System dependencies
#####################

echo "Checking dependencies."
if [ "$(dpkg-query -W -f='${Status}' docker-ce 2>/dev/null | grep -c 'ok installed')" -eq 0 ]; then
    echo "No docker-ce. Installing..."
    sudo apt-get update
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    sudo add-apt-repository \
"deb [arch=armhf] https://download.docker.com/linux/deb ian \
$(lsb_release -cs) \
stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
else
    echo "Dependencies had been installed."
fi

#####################
# Run Docker
#####################

bash /home/pi/raspbian-bits/docker-run.sh

#####################
# Systemd files
#####################

echo "Configuring Systemd..."
# Create directory
# sudo mkdir -p /etc/systemd/system/latest.target.wants
# Copy our service
# sudo cp ./systemd/*.service /etc/systemd/system/latest.target.wants/
sudo cp /home/pi/raspbian-bits/systemd/*.{service,timer} /etc/systemd/system/
# Run our target latest
# sudo systemctl isolate latest.target
# sudo ln -sf /etc/systemd/system/latest.target /etc/systemd/system/default.target
# Enable service
sudo systemctl enable --now miner-updater.service
echo "Complete!"

#####################
# Misc files
#####################

sudo cp ./static/splash.png /usr/share/plymouth/themes/pix/splash.png
