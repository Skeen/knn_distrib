#!/bin/bash

SERVER_URL=http://localhost:3001

TIMEOUT=100000
SPLIT=1

REF_PATH=$1
QUERY_PATH=$2

# Debug info
echo "Server: $SERVER_URL" >&2
echo "Timeout: $TIMEOUT" >&2
echo "Split: $SPLIT" >&2
echo "Reference: $REF_PATH" >&2
echo "Query: $QUERY_PATH" >&2
echo "" >&2

# Upload task
echo "Uploading data for the task:" >&2

NAME=$(curl -q \
  --progress-bar \
  -F "timeout=$TIMEOUT" \
  -F "split=$SPLIT" \
  -F "query=@$QUERY_PATH" \
  -F "reference=@$REF_PATH" \
  $SERVER_URL/knn)

# Print jobname
echo "" >&2
echo "Task submitted: Job has name: $NAME" >&2
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
