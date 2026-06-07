#!/bin/bash
set -e

TARGET_DIR=/home/ubuntu/student
BACKUP_DIR="$TARGET_DIR/backup"

mkdir -p "$BACKUP_DIR"

if [ -f "$TARGET_DIR/student-1.0-SNAPSHOT.jar" ]; then
  cp "$TARGET_DIR/student-1.0-SNAPSHOT.jar" "$BACKUP_DIR/student-1.0-SNAPSHOT.jar.$(date +%Y%m%d%H%M%S)"
  echo "Backed up existing jar to $BACKUP_DIR"
else
  echo "No existing jar to back up."
fi
