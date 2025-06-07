#!/bin/bash

#Prepare PHP-FPM
mkdir -p /run/php
chown -R www-data:www-data /run/php

#Prepare WordPress folder
mkdir -p /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

cd /var/www/wordpress

#Install WordPress if it doesn't exist
if [ ! -f wp-load.php ]; then
    echo "Descargando WordPress..."
    wp core download --locale=es_ES --allow-root
fi

#Wait till the database is created and accesible
echo "Esperando a MariaDB..."
until mysqladmin ping -hmariadb --silent; do
    sleep 2
done

#Verify existece of databases
echo "Comprobando base de datos $MYSQL_DATABASE..."
until mysql -h mariadb -u"$WORDPRESS_DB_USER" -p"$(cat /run/secrets/db_password)" \
      -e "USE $MYSQL_DATABASE;" 2>/dev/null; do
    sleep 2
done

#Configure wp-config.php if it doesn't exist
if [ ! -f wp-config.php ]; then
    echo "Creando wp-config.php..."
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$(cat /run/secrets/db_password)" \
        --dbhost="mariadb:3306" \
        --locale=es_ES \
        --allow-root
fi

#Install WordPress if it isn't installed
if ! wp core is-installed --allow-root; then
    echo "Instalando WordPress..."
    wp core install \
        --url="https://$DOMAIN_NAME" \
        --title="Inception" \
        --admin_user="$WP_SUPER_USER" \
        --admin_password="$(cat /run/secrets/wp_super_password)" \
        --admin_email="iarbaiza@student.42urduliz.com" \
        --skip-email \
        --allow-root

    echo "Habilitando comentarios por defecto..."
    wp option update default_comment_status open --allow-root
fi

#Start PHP-FPM
exec php-fpm7.4 -F