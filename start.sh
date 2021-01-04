#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function start {(
        echo "Starting $DIR/start.py"
        nohup python3 $DIR/start.py </dev/null >/tmp/demo_logs 2>&1 &
)}

start
