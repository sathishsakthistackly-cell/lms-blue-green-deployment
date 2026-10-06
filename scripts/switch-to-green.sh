#!/bin/bash

echo "Checking Green application..."

if curl -f http://localhost:8081/health; then
    echo "Green application is healthy."
else
    echo "Green application health check failed."
    exit 1
fi

echo "Switching traffic to Green..."

sudo sed -i 's/127.0.0.1:8080/127.0.0.1:8081/' /etc/nginx/sites-available/default

sudo nginx -t

if [ $? -eq 0 ]; then
    sudo systemctl reload nginx
    echo "Traffic successfully switched to Green."
else
    echo "Nginx configuration test failed."
    exit 1
fi
