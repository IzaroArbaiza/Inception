#!/bin/bash
set -e

#Ensure that the directory for socket exists
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

#If datadir id empty/doesn't exist, Initiallize MariaDB
if [ ! -d "/var/lib/mysql/mysql" ]; then
  chown -R mysql:mysql /var/lib/mysql

  #Use mysql_install_db to create the system tables
  mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# 3) Cargar contraseñas desde los ficheros de secretos
if [ -f "$MYSQL_PASSWORD_FILE" ]; then
  MYSQL_PASSWORD="$(cat "$MYSQL_PASSWORD_FILE")"
else
  echo "Error: \$MYSQL_PASSWORD_FILE no apunta a un fichero válido."
  exit 1
fi

if [ -f "$MYSQL_ROOT_PASSWORD_FILE" ]; then
  MYSQL_ROOT_PASSWORD="$(cat "$MYSQL_ROOT_PASSWORD_FILE")"
else
  echo "Error: \$MYSQL_ROOT_PASSWORD_FILE no apunta a un fichero válido."
  exit 1
fi

#Create initialization script of the database and users
cat <<EOF > /tmp/init.sql
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo "=== Archivo /tmp/init.sql generado: creará la base de datos y usuarios ==="

#Start MariaDB with --init-file
exec mysqld --bind-address=0.0.0.0 --init-file=/tmp/init.sql