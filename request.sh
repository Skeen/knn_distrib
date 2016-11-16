#!/bin/bash

#echo Reference: $1
#echo Query: $2

SERVER_URL=http://skeen.website:3004

curl -q \
  -F "timeout=10000" \
  -F "split=1" \
  -F "knn=1" \
  -F "query=@$2" \
  -F "reference=@$1" \
  $SERVER_URL/knn
