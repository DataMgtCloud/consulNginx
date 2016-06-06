#!/bin/sh
echo "Start Nginx Service"

exec /usr/sbin/nginx -c /etc/nginx/nginx.conf & CONSUL_TEMPLATE_LOG=debug consul-template -consul=localhost:8500 -template "/etc/consul-templates/nginx.conf:/etc/nginx/conf.d/app.conf:/usr/sbin/nginx -s reload";
