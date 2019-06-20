#!/bin/bash
pm2 stop all
pm2 delete all
sleep 5
pkill -f node
rm -rf /cicd-pipeline-train-schedule-cd/
mkdir -p /cicd-pipeline-train-schedule-cd/