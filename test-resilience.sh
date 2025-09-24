#!/bin/bash
echo "=== Resilience Test ==="
docker-compose up -d --scale api=3
sleep 5
ab -n 5000 -c 5 http://localhost/api/data > load_test.txt &
LOAD_PID=$!
sleep 2
docker kill $(docker ps -q --filter "name=api" | head -1)
sleep 5
docker ps | grep api
kill $LOAD_PID
