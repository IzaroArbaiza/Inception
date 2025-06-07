FROM debian:bullseye

#Install PHP, WP-CLI and dependances
RUN apt-get update && apt-get install -y \
    php php-fpm php-mysql curl wget mariadb-client \
  && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

#Copy configuration PHP-FPM
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

#Copy the script of setup and made it ejecutable
COPY conf/settings.sh /usr/local/bin/settings.sh
RUN chmod +x /usr/local/bin/settings.sh

EXPOSE 9000

#Use settings.sh as boot command
CMD ["/usr/local/bin/settings.sh"]
