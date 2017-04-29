#!/bin/bash

# secure-ssh.sh
# Contributors:
#   Jason Puglisi <jason@puglisi.im>
# Description:
#   Disables insecure and inactive SSH options.
# Notes:
#   This script should be mostly safe, but note that you won't be able to log
#   in over SSH as root, and you won't be able to log in using SSH keys. You
#   may want to eventually add an AllowUsers statement to the end of your sshd
#   config file, but make sure you have multiple points of entry.
# Tested on:
#   Ubuntu 17.04

DATE=`date '+%Y%m%d_%H%M%S'`
mkdir -p ~/backups/sshd.$DATE
echo -e "\e[1m\e[43mBacking up sshd config /etc/ssh/sshd_config to ~/backups/sshd.$DATE/sshd_config\e[0m"
sudo cp /etc/ssh/sshd_config ~/backups/sshd.$DATE/sshd_config
sudo sed -i 's/^.*PermitRootLogin.*$/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^.*PubkeyAuthentication.*$/PubkeyAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^.*X11Forwarding.*$/X11Forwarding no/' /etc/ssh/sshd_config
sudo sed -i 's/^.*PermitEmptyPasswords.*$/PermitEmptyPasswords no/' /etc/ssh/sshd_config
sudo sed -i 's/^.*AllowTcpForwarding.*$/AllowTcpForwarding no/' /etc/ssh/sshd_config
sudo sed -i 's/^.*PermitTunnel.*$/PermitTunnel no/' /etc/ssh/sshd_config
sudo systemctl restart sshd
echo -e "\e[1m\e[42mFinished securing SSH\e[0m"

