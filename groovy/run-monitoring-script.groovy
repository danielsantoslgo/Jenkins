#!groovy
pipeline {
    agent { node 'Node-Name}
  triggers {
        pollSCM 'H * * * *'
    }
        environment {
        SERVER         = ""
        URL_QA           = ""
        URL_PROD         = ""
        AWS_DEPLOY_KEY   = "key.pem"
    }
    stages {
        stage('run script') {
            steps {
                script {
                    sh """#!/bin/bash
                        ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i \$HOME/.ssh/${AWS_DEPLOY_KEY} ${SERVER}@${URL_QA} "./cpu-memory-disk.sh"                
                        ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i \$HOME/.ssh/${AWS_DEPLOY_KEY} ${SERVER}@${URL_PROD} "./cpu-memory-disk.sh"                
                        """
                            slackSend color: 'good', channel: "#channel-name", message: "${env.JOB_NAME} #${env.BUILD_NUMBER}: More info at: ${env.BUILD_URL}"
                }
            }
        }
    }
}
