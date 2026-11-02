#!/bin/bash
# Simple health check script
URL="http://localhost:5000/health"
TIMEOUT=3

response=$(curl -s -w "\n%{http_code}" -m $TIMEOUT $URL)
http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | head -n-1)

if [ "$http_code" == "200" ]; then
    echo "✓ Health check OK (HTTP $http_code)"
    exit 0
else
    echo "✗ Health check FAILED (HTTP $http_code)"
    echo "Response: $body"
    exit 1
fi
