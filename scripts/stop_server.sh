#!/bin/bash
set -e

TARGET_DIR=/home/ubuntu/student

echo "Stopping student app if it is running..."
pkill -f "java -jar $TARGET_DIR/student-1.0-SNAPSHOT.jar" || true
