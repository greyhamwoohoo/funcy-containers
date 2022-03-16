#!/bin/sh 
apt update
apt install npm -y
npm install -g nodemon

. $1
