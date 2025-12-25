#!/bin/bash

# ==========================
# Variables
# ==========================
DATE=$(date +"%Y-%m-%d_%H-%M")
BACKUP_DIR="/opt/docker-prod/backups/backups-db"
CONTAINER_DB="mariadb"

DB_NAME="basededatos"
DB_USER="admin"
DB_PASS="admin"

RETENTION_DAYS=7

# ==========================
# Backup
# ==========================
echo "[INFO] Iniciando backup de MariaDB..."

docker exec "$CONTAINER_DB" \
  mysqldump -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" \
  > "$BACKUP_DIR/db_backup_$DATE.sql"

if [ $? -eq 0 ]; then
  echo "[OK] Backup creado: db_backup_$DATE.sql"
else
  echo "[ERROR] Fallo en el backup"
  exit 1
fi

# ==========================
# Rotación
# ==========================
echo "[INFO] Aplicando rotación (${RETENTION_DAYS} días)..."

find "$BACKUP_DIR" -type f -mtime +$RETENTION_DAYS -name "*.sql" -delete

echo "[OK] Backup finalizado"

