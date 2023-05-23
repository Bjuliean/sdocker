FROM alpine

RUN apk update && apk add --no-cache nginx 
RUN addgroup nginx root
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./mini-server.c /home/mini-server.c
COPY ./start.sh /home/start.sh
RUN apk add --no-cache gcc spawn-fcgi fcgi fcgi-dev musl-dev
RUN for i in $(find /* -type d 2> dev/null); do chown -R nginx:nginx $i 2> dev/null; done
USER nginx
WORKDIR /home/
CMD ["sh", "/home/start.sh"]
HEALTHCHECK --interval=1m --timeout=5s --retries=3 CMD curl -f http://localhost/ || exit 1