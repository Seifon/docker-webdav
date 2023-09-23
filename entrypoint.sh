#!/bin/sh

HTPASSWD_FILE=/opt/webdav/.htpasswd

if [ ! -f "$HTPASSWD_FILE" ]; then
    echo "$WEBDAV_USER:$(openssl passwd -apr1 $WEBDAV_PASSWORD)" > $HTPASSWD_FILE
fi

sed -i "s/80 default_server;/$WEBDAV_PORT default_server;/g" /etc/nginx/http.d/default.conf
sed -i "s/client_max_body_size 0;/client_max_body_size $WEBDAV_MAX_UPLOAD_SIZE;/g" /etc/nginx/http.d/default.conf

exec "$@"