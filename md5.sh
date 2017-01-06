#!/bin/bash

SERVER_URL=http://llama09:3001

NAME=$1

# Debug info
echo "Configuration:" >&2
echo -e "\tServer: $SERVER_URL" >&2
echo -e "\tName: $NAME" >&2
echo "" >&2

curl -qsL $SERVER_URL/awaitMD5?name=$NAME
