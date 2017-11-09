#!/bin/bash

export RESTART_TIMEOUT=90
export SLEEP_INTERVAL=120

if (($RESTART_TIMEOUT > $SLEEP_INTERVAL))
then
  echo "SLEEP_INTERVAL must be greater than RESTART_TIMEOUT!"
  exit 1
fi

cmd.exe /C "cd claymore-v10-0 && start start_only_eth.bat"

while true
do
  git remote update origin
  echo "Pulled delta"

  if [ $(git rev-list --count master..origin/master) -eq 0 ]
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
