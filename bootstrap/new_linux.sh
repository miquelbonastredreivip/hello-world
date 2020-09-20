#!/bin/sh
#
# Things I usually do with a new linux system
#
UPDATE_URL=https://raw.githubusercontent.com/mbonastre/hello-world/master/bin/update_apt.sh
BIN_DIR=/root/bin
CRON_DIR=/etc/cron.daily
HOSTNAME="albert-pizzicato"

sudo apt-get update
sudo apt-get install wget
sudo mkdir "${BIN_DIR}"
sudo wget -O "${CRON_DIR}/update-packages" "${UPDATE_URL}"
sudo chmod a+x "${CRON_DIR}/update-packages"

[ "${HOSTNAME}" ] && sudo hostname "${HOSTNAME}"

