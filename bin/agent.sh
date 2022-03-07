#!/bin/echo This file must be run in the same process with "." (source)
#
# This script allows easy use of "ssh-agent" from any terminal.
# Works in Linux and MacOS.
#
# First time executed:
#  - Runs ssh-agent 
#  - Save variables to connect to agent
#  - Loads default key (Ask for key password if necessary)
#
# Following executions:
#  - Just load environ variables
#
# If key TTL has expired:
#  - Loads it again (asking password)
#
# If saved environment variables are stale
#  - Removes the file
#  - Launches another agent
#
# Default key may depend on system and key type.
# In my case: id_rsa.
#
#
# To use this script, add these lines at the end of ".bashrc"
# (or equivalent file; I have only tested it in bash):
#
#  if [ -x ~/bin/agent.sh ] ; then
#    . ~/bin/agent.sh
#  fi
#

# First step:
#  - Verify if ssh-agent is running and load variables
#  - If socket invalid, remove variables file (it is stale)
#

if [ -f ~/.ssh/ssh_auth_env ]; then
   .  ~/.ssh/ssh_auth_env
   [ -S "${SSH_AUTH_SOCK}" ] || rm ~/.ssh/ssh_auth_env
fi

# Second step:
#  - If ssh-agent is not running launch it
#  - Store and load variables
#  - Set TTL (maximum time to ask for password again)
#      130000 ~ 36 hores (asks at the begining of work day, every other day)
#      1300000 ~ 15 dies
#      2600000 ~ 30 dies (I use it on holidays if I leave scheduled processes)
#
if [ ! -f ~/.ssh/ssh_auth_env ]; then
  ssh-agent -t 130000 > ~/.ssh/ssh_auth_env
  .  ~/.ssh/ssh_auth_env
fi


# Third step:
#  - If ssh-agent doesn't have keys, load default identity (id_rsa)
#  - (If key has password, asks for it)
#
# You can modify this part if you want more keys or non-default ones:
#  - One non-default key: just add the path-name to the second "ssh-add"
#  - More than one key: replicate lines, checking for the specific key presence
#
ssh-add -l || ssh-add

# Possible improbements:
#  - Currently, the password is requested in the terminal.
#    With proper configuration, an X11 window could request it.
#    Look at "SSH_ASKPASS" variable.
#
