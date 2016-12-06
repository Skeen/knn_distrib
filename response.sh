#!/bin/bash

SERVER_URL=http://localhost:3001

NAME=$1

# Debug info
echo "Configuration:" >&2
echo -e "\tServer: $SERVER_URL" >&2
echo -e "\tName: $NAME" >&2
echo "" >&2

# Print out progress information
while true; do
    PROGRESS=$(curl -qs $SERVER_URL/progress?name=$NAME)
    echo -en "\r\e[0K Progress: $PROGRESS" >&2
    if [ "$PROGRESS" = "100%" ]; then
        break
    fi
    sleep 5
done

# Download the result
while true; do
    curl -qs $SERVER_URL/awaitComplete?name=$NAME
    if [ $? -eq 0 ]; then
        exit 0
    fi
    sleep 5
done
