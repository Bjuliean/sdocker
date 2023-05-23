FROM nginx

COPY nginx.conf /etc/nginx/
COPY start.sh /
COPY mini-server.c /

RUN apt-get update &&  \
    apt-get install -y gcc spawn-fcgi libfcgi-dev && \ 
    gcc mini-server.c -o mini-server -l fcgi && \
    chmod 777 /start.sh

ENTRYPOINT ["./start.sh"]