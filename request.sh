#!/bin/bash

SERVER_URL=http://localhost:3001

TIMEOUT=100000
SPLIT=1

REF_PATH=$1
QUERY_PATH=$2
DTW_ARGS=$3

# Debug info
echo "Configuration:" >&2
echo -e "\tServer: $SERVER_URL" >&2
echo -e "\tTimeout: $TIMEOUT" >&2
echo -e "\tSplit: $SPLIT" >&2
echo -e "\tReference: $REF_PATH" >&2
echo -e "\tQuery: $QUERY_PATH" >&2
echo -e "\tDTW-Args: $DTW_ARGS" >&2
echo "" >&2

# Upload task
echo "Uploading data for the task:" >&2

NAME=$(curl -q \
  --progress-bar \
  -F "timeout=$TIMEOUT" \
  -F "split=$SPLIT" \
  -F "query=@$QUERY_PATH" \
  -F "reference=@$REF_PATH" \
  -F "dtw_args=$DTW_ARGS" \
  $SERVER_URL/knn)

# Print jobname
echo "" >&2
echo "Task submitted:" >&2
echo -e "\tJob has name: $NAME" >&2
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
