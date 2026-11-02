#!/bin/bash
# Simple database backup script
# Run with: ./backup_db.sh

BACKUP_DIR="./backups"
mkdir -p "$BACKUP_DIR"

FILE="$BACKUP_DIR/testdb_$(date +%F_%H-%M).sql.gz"

echo "Backing up database to $FILE..."
docker exec simple-db pg_dump -U testuser testdb | gzip > "$FILE"

echo "Backup complete: $FILE"
echo "Backups on disk:"
ls -lh "$BACKUP_DIR"
