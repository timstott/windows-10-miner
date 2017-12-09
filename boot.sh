#!/bin/bash

export RESTART_TIMEOUT=90
export SLEEP_INTERVAL=120

log()
{
  echo "[`date -u +'%Y-%m-%dT%H:%M:%SZ'`] - ${*}"
}

log "Started boot.sh"

if (($RESTART_TIMEOUT > $SLEEP_INTERVAL))
then
  log "SLEEP_INTERVAL must be greater than RESTART_TIMEOUT!"
  exit 1
fi

cmd.exe /C "cd claymore-v10-0 && start start_only_eth.bat"

while true
do
  log "$(git remote update origin)"
  log "Pulled delta"

  if [ $(git rev-list --count master..origin/master) -eq 0 ]
  then
    log "No updates"
  else
    shutdown.exe -r -f -t $RESTART_TIMEOUT
    log "Scheduled shutdown"
    # Execute update in other process because Windows cannot update currently opened file
    sh -c 'sleep 3; git reset --hard origin/master; echo "Updated code"; sleep 10' &
    exit 0
  fi

  log "Sleep $SLEEP_INTERVAL seconds"
  sleep $SLEEP_INTERVAL
done
