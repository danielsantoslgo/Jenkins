#!/bin/bash

# Set input variables PATH
SOURCE_PATH="$HOME/jenkins-volumes/jenkins-customized-docker-v2/*"
DESTINATION_PATH="$HOME/jenkins-volumes/jenkins-customized-docker-old"

# Create a rsync function
function rsync_jenkins_home () {

    sudo rsync -av $SOURCE_PATH $DESTINATION_PATH

    status_rsync=$?

# Evaluate the status of rsync
    if [ $status_rsync -ne 0 ]; then
        echo "There was a error with the rsync process: $status_rsync"
    else
        echo "rsync was success: $status_rsync"
    fi

}

# Calling the function
rsync_jenkins_home