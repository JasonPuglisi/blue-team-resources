#!/bin/bash

# clear-aliases.sh
# Contributors:
#   Jason Puglisi <jason@puglisi.im>
# Description:
#   Backs up and clears Bash alises.
# Notes:
#   This may clear some default aliases defined by your operating system, but
#   those usually aren't too important. This script should be run before any
#   others to ensure any commands being run by scripts aren't being aliased to
#   something else. You should also check common files such as .bashrc and to
#   .bash_profile to make sure aliases aren't set again in other sessions.
# Tested on:
#   Ubuntu 17.04

DATE=`date '+%Y%m%d_%H%M%S'`
\echo -e "\e[1m\e[43mBacking up aliases to ~/backups/alias.$DATE\e[0m"
\mkdir -p ~/backups
\alias > ~/backups/alias.$DATE
\unalias -a
echo -e "\e[1m\e[42mFinished clearing aliases\e[0m"

