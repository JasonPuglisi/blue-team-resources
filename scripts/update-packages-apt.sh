#!/bin/bash

# update-packages-apt.sh
# Contributors:
#   Jason Puglisi <jason@puglisi.im>
# Description:
#   Updates APT packages and removes unused ones.
# Notes:
#   This operation may take a while depending on how outdated the system is.
#   Updates may break configuration files or services, so use caution. A reboot
#   is recommended after updating, but consider rules, scored services, and if
#   your machine can reboot without breaking.
# Tested on:
#   Ubuntu 17.04

sudo apt-get autoclean && \
sudo apt-get update && \
sudo apt-get upgrade && \
sudo apt-get dist-upgrade && \
sudo apt-get autoremove
echo -e "\e[1m\e[42mFinished updating packages, reboot recommended\e[0m"

