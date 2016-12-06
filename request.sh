#!/bin/bash

SERVER_URL=http://localhost:3001

REF_PATH=$1
QUERY_PATH=$2
DTW_ARGS=$3
SPLIT=$4
TIMEOUT=$5

# Ensure that split is set
if [ -z "$SPLIT" ]; then
    SPLIT=1
    echo "No split set, using '$SPLIT'" >&2
fi

# Ensure that timeout is set
if [ -z "$TIMEOUT" ]; then
    TIMEOUT=100000
    echo "No timeout set, using '$TIMEOUT'" >&2
fi

# Debug info
echo "Configuration:" >&2
echo -e "\tServer: $SERVER_URL" >&2
echo -e "\tTimeout: $TIMEOUT" >&2
echo -e "\tSplit: $SPLIT" >&2
echo -e "\tReference: $REF_PATH" >&2
echo -e "\tQuery: $QUERY_PATH" >&2
echo -e "\tDTW-Args: $DTW_ARGS" >&2
echo -e "\tQuery Split: $SPLIT" >&2
echo -e "\tTimeout: $TIMEOUT" >&2
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

echo $NAME
