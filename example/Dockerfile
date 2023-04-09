FROM nginx:latest

MAINTAINER joramuns

COPY ./server/nginx.conf /etc/nginx
COPY ./server/mini-server.c /etc/

RUN apt update && \
    apt install gcc libfcgi-dev spawn-fcgi -y && \
    rm -rf /var/lib/apt/lists && \
    gcc /etc/mini-server.c -o /etc/mini-server.fcgi -lfcgi && \
    chown -R nginx:nginx /etc/nginx/nginx.conf && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /home && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid && \
    chown 755 usr/bin/chsh && \
    chown 755 bin/mount && \
    chown 255 usr/bin/chage && \
    chown 755 usr/bin/chfn && \
    chown 755 usr/bin/gpasswd && \
    chown 755 bin/umount && \
    chown 255 sbin/unix_chkpwd && \
    chown 755 usr/bin/passwd && \
    chown 755 bin/su && \
    chown 255 usr/bin/wall && \
    chown 755 usr/bin/newgrp && \
    chown 255 usr/bin/expiry;

USER nginx

HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl --fail localhost:81 || exit 1

CMD spawn-fcgi -p 8080 /etc/mini-server.fcgi && \
    nginx
