FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server && \
    mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./conf/settings.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/settings.sh

EXPOSE 3306

CMD ["/usr/local/bin/settings.sh"]
