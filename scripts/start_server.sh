#!/bin/bash
set -e

TARGET_DIR=/home/ubuntu/student
JAR_FILE="$TARGET_DIR/student-1.0-SNAPSHOT.jar"
LOG_FILE="$TARGET_DIR/student.log"

mkdir -p "$TARGET_DIR"

if [ ! -f "$JAR_FILE" ]; then
  echo "ERROR: Jar file not found: $JAR_FILE"
  exit 1
fi

nohup java -jar "$JAR_FILE" > "$LOG_FILE" 2>&1 &

echo "Started student app with jar: $JAR_FILE"
