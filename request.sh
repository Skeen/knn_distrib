#!/bin/bash

#echo Reference: $1
#echo Query: $2

curl -q \
  -F "timeout=10000" \
  -F "split=100" \
  -F "knn=1" \
  -F "query=@$2" \
  -F "reference=@$1" \
  http://localhost:3001/knn
