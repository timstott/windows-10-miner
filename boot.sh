#!/bin/bash

export WORKDIR=$PWD
export RESTART_TIMEOUT=90
export SLEEP_INTERVAL=120

if (($RESTART_TIMEOUT > $SLEEP_INTERVAL))
then
  echo "SLEEP_INTERVAL must be greater than RESTART_TIMEOUT!"
  exit 1
fi

while true
do
  git remote update origin
  echo "Pulled delta"

  if [ "$(git status -u no | grep 'Your branch is up-to-date')" ]
  then
    echo "No updates"
  else
    shutdown.exe -r -f -t $RESTART_TIMEOUT
    echo "Scheduled shutdown"
    # Execute update in other process because Windows cannot update currently opened file
    sh -c 'sleep 3; git reset --hard origin/master; echo "Updated code"; sleep 3' &
    exit 0
  fi

  echo "Sleep $SLEEP_INTERVAL seconds"
  sleep $SLEEP_INTERVAL
done
