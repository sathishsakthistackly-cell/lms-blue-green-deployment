#!/bin/bash

echo "Rolling back traffic to Blue..."

sudo sed -i 's/127.0.0.1:8081/127.0.0.1:8080/' /etc/nginx/sites-available/default

sudo nginx -t

if [ $? -eq 0 ]; then
    sudo systemctl reload nginx
    echo "Traffic successfully rolled back to Blue."
else
    echo "Nginx configuration test failed."
    exit 1
fi
