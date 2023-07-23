#!/bin/sh 
cd /workspace

# Sleep forever - run this command when using VsCode: this keeps the container open so we can Shell in
/bin/sh -c "while sleep 1000; do :; done"
