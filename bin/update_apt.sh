#!/bin/sh

LOG_FILE=/var/log/update_apt.log

exec >> ${LOG_FILE} 2>&1

HLine="##################################################################################################"

echo ${HLine}
echo
date "+          START PACKAGE UPDATE PROCESS          %Y-%m-%dT%H:%M:%S"
echo
echo ${HLine}

sudo apt-get -y update ; sudo apt-get -y dist-upgrade ; sudo apt-get -y autoremove ; sudo apt-get -y autoclean

echo
date "+Process ended at %Y-%m-%dT%H:%M:%S"
echo ${HLine}
