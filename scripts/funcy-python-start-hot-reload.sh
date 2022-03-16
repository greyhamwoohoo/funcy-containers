#!/bin/sh 
cd /workspace

nodemon -w funcy-python/*py -w funcy-python/function.json --legacy-watch --exec "func host start --verbose"
