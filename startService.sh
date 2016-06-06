#!/bin/sh
echo "Start Nginx Service"
exec /usr/sbin/nginx -c /etc/nginx/nginx.conf & CONSUL_TEMPLATE_LOG=debug consul-template -consul=localhost:8500 -template "$CT_FILE:$NX_FILE:/usr/sbin/nginx -s reload";
