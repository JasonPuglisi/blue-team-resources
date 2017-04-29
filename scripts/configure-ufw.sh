#!/bin/bash

# configure-ufw.sh
# Contributors:
#   Jason Puglisi <jason@puglisi.im>
# Description:
#   Configures UFW with both inbound and outbound rules.
# Usage:
#   configure-ufw.sh <INBOUND PORTS> [OUTBOUND PORTS]
#   - <INBOUND PORTS> and [OUTBOUND PORTS] are comma-separated lists
#     (no spaces) of ports in the following format: <PORT NUMBER>[/<tcp|udp>]
#   - If /tcp is provided, TCP connections will be allowed. If /udp is
#     provided, UDP connections will be allowed. If neither are provided, both
#     TCP and UDP connections will be allowed.
#   - If [OUTBOUND PORTS] is not provided, all outbound connections will be
#     allowed.
#   - Example: configure-ufw.sh 22/tcp,8080/tcp 53,80/tcp,443/tcp
# Notes:
#   It's typically a good idea to only allow inbound connections for scored
#   services with their respective protocols, and SSH if you're connecting
#   remotely. If you provide outbound ports, make sure you leave ones open that
#   your machine requires, such as DNS and HTTP(S).
#
# Tested on:
#   Ubuntu 17.04

INBOUND_PORTS=$(echo $1 | sed "s/,/ /g")
OUTBOUND_PORTS=$(echo $2 | sed "s/,/ /g")
if [[ ! -z $INBOUND_PORTS ]]
then
  sudo ufw status >/dev/null 2>/dev/null
  if [[ $? -ne 0 ]]
  then
    echo -e "\e[1m\e[43mUFW not found, attempting to install from APT\e[0m"
    sudo apt-get update || exit
    sudo apt-get -y install ufw || exit
  fi
  sudo echo y | sudo ufw reset
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  for inbound_port in $INBOUND_PORTS
  do
    sudo ufw allow $inbound_port
  done
  if [[ ! -z $OUTBOUND_PORTS ]]
  then
    sudo ufw default deny outgoing
    for outbound_port in $OUTBOUND_PORTS
    do
      sudo ufw allow out $outbound_port
    done
  fi
  sudo ufw enable
  echo -e "\e[1m\e[43mPrinting status, verify rules are correct\e[0m"
  sudo ufw status verbose
  echo -e "\e[1m\e[42mFinished configuring UFW\e[0m"
else
  echo "Usage: configure-ufw.sh <INBOUND_PORTS> [OUTBOUND_PORTS]"
fi

