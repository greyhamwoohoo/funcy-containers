#!/bin/sh 

apt update
apt install npm -y
npm install -g nodemon

cd /workspace

nodemon -w funcy-python/*py -w funcy-python/function.json --legacy-watch --exec "func host start"
