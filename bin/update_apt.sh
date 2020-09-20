#!/bin/sh

HLine="##################################################################################################"

echo ${HLine}
echo
date "+          START UBUNTU UPDATE PROCESS          %Y-%m-%dT%H:%M:%S"
echo
echo ${HLine}

sudo apt-get -y update ; sudo apt-get -y dist-upgrade ; sudo apt-get -y autoremove ; sudo apt-get -y autoclean

echo
date "+Process ended at %Y-%m-%dT%H:%M:%S"
echo ${HLine}
