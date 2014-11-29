#!/bin/sh
docker run -v $(pwd)/.jenkins:/mnt/backup ${1} tar cvf /mnt/backup/backup.tar /home/cicd/.jenkins
