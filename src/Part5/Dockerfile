FROM nginx
USER root
WORKDIR /home/
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./my_server.c .
COPY ./my_script.sh .

RUN     chmod +x my_script.sh \
        && apt-get update \
        && apt-get install -y gcc spawn-fcgi libfcgi-dev \
        && chown -R nginx:nginx /etc/nginx/nginx.conf \
        && chown -R nginx:nginx /var/cache/nginx \
        && chown -R nginx:nginx /home \
        && touch /var/run/nginx.pid \
        && chown -R nginx:nginx /var/run/nginx.pid \
        && rm -rf /var/lib/apt/lists/*

RUN     chmod u-s /usr/bin/su; \
        chmod u-s /usr/bin/mount; \
        chmod u-s /usr/bin/gpasswd; \
        chmod g-s /usr/bin/chage; \
        chmod g-s /usr/sbin/pam_extrausers_chkpwd; \
        chmod g-s /usr/sbin/unix_chkpwd; \
        chmod g-s /usr/bin/expiry; \
        chmod u-s /usr/bin/chfn; \
        chmod u-s /usr/bin/chsh; \
        chmod u-s /usr/bin/passwd; \
        chmod u-s /usr/bin/newgrp; \
        chmod u-s /usr/bin/umount; \
        chmod g-s /usr/bin/wall

USER nginx

CMD     ./my_script.sh

HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl -sS 127.0.0.1 || exit 1
