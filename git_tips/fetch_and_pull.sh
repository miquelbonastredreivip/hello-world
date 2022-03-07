#!/bin/sh

#
# Mantains current repo updated with changes in origin
#
# If some step fails because of some conflict, the process stops.
#
# Si algun pas falla per algun conflicte, el procés s'atura.
#
# Passos:
# - Fetch
# - Pull current branch (it could be ${MAIN})
# - Pull from origin ${MAIN} to local ${MAIN}
#

# Choose your player:
#MAIN="main"
MAIN="master"

date &&
  git status &&
  echo FETCH: && git fetch --prune &&
  echo PULL current branch: && git pull &&
  echo PULL ${MAIN}: && git pull origin ${MAIN}:${MAIN}

if [ "$?" != 0 ] ; then
  echo "ERROR: something went wrong"
  exit 1
fi

