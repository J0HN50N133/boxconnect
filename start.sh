#!/bin/sh
echo "$PASSWORD" | openconnect $SERVER \
    --user=$USERNAME \
    --passwd-on-stdin \
    -m 1290 \
    --useragent="AnyConnect whatever" \
    --background &
exec /bin/bash
