#!/bin/bash
pm2 stop all
pm2 delete all
sleep 5
pkill -f node
rm -rf /home/ubuntu/cicd-pipeline-train-schedule-cd/
mkdir -p /home/ubuntu/cicd-pipeline-train-schedule-cd/