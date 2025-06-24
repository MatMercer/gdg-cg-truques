#!/bin/bash

# Cleanup function to kill the donut process
cleanup() {
    if [ ! -z "$DONUT_PID" ]; then
        kill $DONUT_PID 2>/dev/null || true
    fi
    exit
}

# Set up trap to catch Ctrl+C and other termination signals
trap cleanup SIGINT SIGTERM SIGQUIT

docker compose up -d

gcc -Wno-implicit-function-declaration -Wno-string-plus-char -Wno-implicit-int -o donut donut.c

clear
./donut & 
DONUT_PID=$!
read
kill $DONUT_PID

open presentation/index.html
