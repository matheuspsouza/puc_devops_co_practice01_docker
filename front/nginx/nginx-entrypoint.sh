#!/bin/sh

# Substitute only exepected environment variables into the NGINX configuration
envsubst '${BACKEND_HOST} ${BACKEND_PORT} ${BACKEND_PATH}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start NGINX in background
nginx -g 'daemon off;'
