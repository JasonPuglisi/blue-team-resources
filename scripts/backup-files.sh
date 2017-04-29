#!/bin/bash

# backup-files.sh
# Contributors:
#   Jason Puglisi <jason@puglisi.im>
# Description:
#   Backs up general system files.
# Notes:
#   This backs up a number of common files and directories. It may take a while
#   depending on the system and files. Be wary of your storage usage. You may
#   want to move the backup to a more hidden directory so attackers don't just
#   delete your "backups" folder.
# Tested on:
#   Ubuntu 17.04

DATE=`date '+%Y%m%d_%H%M%S'`
# Backup Bash aliases
echo -e "\e[1m\e[43mBacking up aliases to ~/backups/full.$DATE/alias\e[0m"
mkdir -p ~/backups/full.$DATE
# Backup main system crontab
echo -e "\e[1m\e[43mBacking up main system crontab /etc/crontab to ~/backups/full.$DATE/crontab\e[0m"
sudo cp /etc/crontab ~/backups/full.$DATE/crontab
# Backup system crontabs
for cron_type in d hourly daily weekly monthly
do
  echo -e "\e[1m\e[43mBacking up system crontabs /etc/cron.$cron_type to ~/backups/full.$DATE/cron.$cron_type\e[0m"
  sudo cp -a /etc/cron.$cron_type ~/backups/full.$DATE/cron.$cron_type
done
# Backup user crontabs
echo -e "\e[1m\e[43mBacking up user crontabs /var/spool/cron/crontabs to ~/backups/full.$DATE/crontabs\e[0m"
sudo cp -a /var/spool/cron/crontabs ~/backups/full.$DATE/crontabs
# Backup sshd config
echo -e "\e[1m\e[43mBacking up sshd config /etc/ssh/sshd_config to ~/backups/full.$DATE/sshd_config\e[0m"
sudo cp /etc/ssh/sshd_config ~/backups/full.$DATE/sshd_config
# Backup UFW state
echo -e "\e[1m\e[43mBacking up /etc/ufw to ~/backups/full.$DATE/ufw\e[0m"
sudo cp -a /etc/ufw ~/backups/full.$DATE/ufw
# Backup /etc/passwd
echo -e "\e[1m\e[43mBacking up /etc/passwd to ~/backups/full.$DATE/passwd\e[0m"
sudo cp /etc/passwd ~/backups/full.$DATE/passwd
# Backup /etc/shadow
echo -e "\e[1m\e[43mBacking up /etc/shadow to ~/backups/full.$DATE/shadow\e[0m"
sudo cp /etc/shadow ~/backups/full.$DATE/shadow
# Backup /var/www
echo -e "\e[1m\e[43mBacking up /var/www to ~/backups/full.$DATE/www\e[0m"
sudo cp -a /var/www ~/backups/full.$DATE/www
# Backup /var/log
echo -e "\e[1m\e[43mBacking up /var/log to ~/backups/full.$DATE/log\e[0m"
sudo cp -a /var/log ~/backups/full.$DATE/log
echo -e "\e[1m\e[42mFinished backing up files\e[0m"

