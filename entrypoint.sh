#!/bin/sh
set -e

echo "Entrypoint: Tribute listener is waiting for 30 seconds..."
sleep 30

echo "Entrypoint: Starting tribute-hook as nonroot user..."
exec /app/tribute-hook