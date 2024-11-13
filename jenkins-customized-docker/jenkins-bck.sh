#!/bin/bash

# Input variables

# Set the location of the Jenkins home directory
JENKINS_HOME="$HOME/jenkins-volumes/jenkins-customized-docker-v2"

# Set the location for the backups
BACKUP_DIR="$HOME/jenkins-volumes/jenkins-backups"

# Set the maximum number of backups to keep
MAX_BACKUPS=7

# Get the current date
CURR_DATE=$(date +%Y-%m-%d)

# Create the backup directory if it does not exist
if [ ! -d "$BACKUP_DIR" ]; then
  sudo mkdir -p "$BACKUP_DIR"
fi

# Create a new backup
function create_bck () {

    sudo tar -czf "$BACKUP_DIR/jenkins_home_$CURR_DATE.tar.gz" "$JENKINS_HOME"

    status_tar=$?

    # Evaluate the status of tar
    if [ $status_tar -ne 0 ]; then
        echo "There was a error with the tar process: $status_tar"
    else
        echo "tar was success: $status_tar"
    fi

}

function remove_old_bck () {

    # Remove old backups
    NUM_BACKUPS=$(ls -1 "$BACKUP_DIR" | wc -l)
    if [ "$NUM_BACKUPS" -gt "$MAX_BACKUPS" ]; then
      ls -t "$BACKUP_DIR" | tail -n +$((MAX_BACKUPS+1)) | xargs rm -f
    fi

}

# Calling functions

create_bck
remove_old_bck

# Create a crontab, just for example
# 0 4 * * * /path/to/backup_script.sh
