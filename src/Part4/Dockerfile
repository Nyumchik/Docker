FROM nginx

USER root

WORKDIR /home/

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./my_server.c .
COPY ./my_script.sh .

RUN     chmod +x my_script.sh \
        && apt-get update \
        && apt-get install -y gcc spawn-fcgi libfcgi-dev

CMD     ./my_script.sh
