#!/bin/bash

echo "Stopping containers..."
docker compose down

echo "Cleaning Docker..."
docker system prune -a -f

echo "Done."
