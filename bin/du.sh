#!/bin/sh

BASE_DIR="$( cd $( dirname $0 ) ; pwd -L )"

DIR="$HOME"
DIR="/"

exec > ${BASE_DIR}/du.log  2>&1

LOG_FILE="$( date "+${BASE_DIR}/du.%d.log" )"
DU_FILE="$( date "+${BASE_DIR}/du.%d.txt" )"

exec > ${LOG_FILE} 2>&1

sudo du -kx ${DIR} | sort -n > ${DU_FILE}

