FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && \
    mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/iarbaiza.key \
    -out /etc/nginx/ssl/iarbaiza.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=${DOMAIN_NAME}"

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

