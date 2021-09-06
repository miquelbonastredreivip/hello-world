#!/bin/sh

#
# Push branch changes to ${MAIN} using Fast-Forward
#
# If some step fails because of some conflict, the process stops.
#
# Steps:
#  - ToDo
#
# Fem "push" de canvis en una branca cap a ${MAIN}, usant Fast-Forward
#
# Si algun pas falla per algun conflicte, el procés s'atura.
#
# Passos:
# - Actualitzem info local i remot (fetch/pull)
# - Ens assegurem que tenim els darrers canvis (rebase)
# - Apliquem canvis (push) des d'aquesta branca (HEAD) cap a ${MAIN} remot
# - Apliquem canvis a ${MAIN} local (pull)
#

# Choose your player:
#MAIN="main"
MAIN="master"

date &&
echo "ACTUALITZEM LOCAL REPO:" &&
  echo fetch: && git fetch &&
  echo pull ${MAIN}: && git pull origin ${MAIN}:${MAIN} &&

echo "REBASE FROM ${MAIN}:" &&
  echo stash: && git stash &&
  echo rebase: && git rebase ${MAIN} && 

echo "PUSHES:" &&
  echo push-branch:      &&  git push &&
  echo push-to-${MAIN}:  &&  git push origin HEAD:${MAIN} &&

echo "ACTUALITZEM LOCAL ${MAIN}:" &&
  echo pull-${MAIN} && git pull origin ${MAIN}:${MAIN}


echo "DON'T FORGET !!!!! Do you need to do some of these? "

echo "Here:"
echo "  git stash pop"

echo "Other clones:"
echo "  git fetch && git pull"

echo "Branch cleaning:"
echo " - delete local : git branch -d BRANCH"
echo " - delete remote: git push origin --delete BRANCH"
echo " - delete tracking: git remote prune origin"

