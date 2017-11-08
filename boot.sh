#!/bin/bash

export WORKDIR=$PWD
export RESTART_TIMEOUT=90
export SLEEP_INTERVAL=120

if ( ($RESTART_TIMEOUT > $SLEEP_INTERVAL) )
then
  echo "SLEEP_INTERVAL must be greater than RESTART_TIMEOUT!"
  exit 1
fi

while true
do
  git remote update origin
  echo "Updated remote"

  if [ "$(git status -u no | grep 'Your branch is up-to-date')" ]
  then
    echo "No updates"
  else
    git reset --hard origin/master
    echo "Updated local"
    shutdown.exe -r -f -t $RESTART_TIMEOUT
    echo "Scheduled shutdown"
  fi

  echo "Sleep $SLEEP_INTERVAL seconds"
  sleep $SLEEP_INTERVAL
done
