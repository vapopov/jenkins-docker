#!/bin/sh
sudo docker ps -a -q | xargs -n 1 -I {} sudo docker rm {}
