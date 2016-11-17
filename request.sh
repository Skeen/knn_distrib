#!/bin/bash

#echo Reference: $1
#echo Query: $2

SERVER_URL=http://localhost:3001

TIMEOUT=10000
SPLIT=1000
KNN=1

REF_PATH=$1
QUERY_PATH=$2

NAME=$(curl -q \
  -F "timeout=$TIMEOUT" \
  -F "split=$SPLIT" \
  -F "knn=$KNN" \
  -F "query=@$QUERY_PATH" \
  -F "reference=@$REF_PATH" \
  $SERVER_URL/knn)

#echo "Job has name: $NAME"

curl -q \
  $SERVER_URL/awaitComplete?name=$NAME
