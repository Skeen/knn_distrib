#!/bin/bash

#echo Reference: $1
#echo Query: $2

SERVER_URL=http://localhost:3001

TIMEOUT=100000
SPLIT=1

REF_PATH=$1
QUERY_PATH=$2

NAME=$(curl -q \
  -F "timeout=$TIMEOUT" \
  -F "split=$SPLIT" \
  -F "query=@$QUERY_PATH" \
  -F "reference=@$REF_PATH" \
  $SERVER_URL/knn)

echo "Job has name: $NAME" >&2

while true; do
    curl -q $SERVER_URL/awaitComplete?name=$NAME
    if [ $? -eq 0 ]; then
        exit 0
    fi
    sleep 5
done
