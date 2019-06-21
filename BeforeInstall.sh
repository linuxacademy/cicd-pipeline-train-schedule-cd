#!/bin/bash
#su - ubuntu -c "/usr/bin/pm2 stop all"
su - ubuntu -c "/usr/bin/pm2 stop all"
su - ubuntu -c "/usr/bin/pm2 delete all"
sleep 5
pkill -f node
rm -rf /home/ubuntu/cicd-pipeline-train-schedule-cd/
mkdir -p /home/ubuntu/cicd-pipeline-train-schedule-cd/
