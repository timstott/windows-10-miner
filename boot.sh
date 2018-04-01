#!/bin/bash

export RESTART_TIMEOUT=90
export SLEEP_INTERVAL=30

log()
{
  echo "[`date -u +'%Y-%m-%dT%H:%M:%SZ'`] - ${*}"
}

log "Started boot.sh"

sh -c 'cmd.exe /C "cd claymore && start start_with_config.bat"'

while true
do
  log "Sleep $SLEEP_INTERVAL seconds"
  sleep $SLEEP_INTERVAL

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
done
