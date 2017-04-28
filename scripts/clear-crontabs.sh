#!/bin/bash

# clear-crontabs.sh
# Contributors:
#   Jason Puglisi <jason@puglisi.im>
# Description:
#   Backs up and clears all crontabs.
# Notes:
#   Ensure that no scored services are relying on crontabs, or make note of
#   those that do to restore them later.
# Tested on:
#   Ubuntu 17.04

DATE=`date '+%Y%m%d_%H%M%S'`
# Backup and remove main system crontab
echo -e "\e[1m\e[43mBacking up main system crontab /etc/crontab to ~/backups/crontab.$DATE\e[0m"
\mkdir -p ~/backups
sudo cp /etc/crontab ~/backups/crontab.$DATE
sudo rm /etc/crontab
# Backup and remove system crontabs
for cron_type in d hourly daily weekly monthly
do
  echo -e "\e[1m\e[43mBacking up system crontabs /etc/cron.$cron_type to ~/backups/cron.$cron_type.$DATE\e[0m"
  sudo cp -a /etc/cron.$cron_type ~/backups/cron.$cron_type.$DATE
  sudo rm -r /etc/cron.$cron_type/*
done
# Backup and remove user crontabs
echo -e "\e[1m\e[43mBacking up user crontabs /var/spool/cron/crontabs to ~/backups/crontabs.$DATE\e[0m"
sudo cp -a /var/spool/cron/crontabs ~/backups/crontabs.$DATE
for user in `cut -f1 -d: /etc/passwd`
do
  sudo crontab -u $user -r
done
echo -e "\e[1m\e[42mFinished clearing crontabs\e[0m"

