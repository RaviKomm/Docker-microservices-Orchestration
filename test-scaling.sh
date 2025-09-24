#!/bin/bash
echo "=== Scaling Test ==="
docker-compose up -d --scale api=1
sleep 5
ab -n 1000 -c 10 http://localhost/api/data > results_1.txt
docker-compose up -d --scale api=3
sleep 5
ab -n 1000 -c 10 http://localhost/api/data > results_3.txt
