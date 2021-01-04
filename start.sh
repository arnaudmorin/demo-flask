#!/bin/bash
# How to run in background:
# nohup start.sh &

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function quit {
        rm -f /tmp/demo_lock
        jobs -p | xargs -r kill
}

trap quit EXIT

touch /tmp/demo_lock
echo "Starting $DIR/start.py"
python3 $DIR/start.py </dev/null >/tmp/demo_logs 2>&1
