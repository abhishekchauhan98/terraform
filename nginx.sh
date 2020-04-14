#!/bin/bash
sudo apt update
sudo apt install nginx -y
echo "<h1>THIS WAS DONE THROUGH TERRAFORM</h1>" > index.html
mv index.html /var/www/html/