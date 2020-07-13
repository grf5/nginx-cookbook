#!/bin/env bash

printf "Creating the NGINX configuration directory\n"
sudo mkdir /etc/ssl/nginx
cd /etc/ssl/nginx

printf "Copying the NGINX certificate and key from the current folder\n"
sudo cp nginx-repo.crt /etc/ssl/nginx/
sudo cp nginx-repo.key /etc/ssl/nginx/

printf "Downloading the NGINX signing key and adding to aptitude\n"
sudo wget https://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key

printf "Install the apt-utils package and the NGINX Plus repository\n"
sudo apt-get install apt-transport-https lsb-release ca-certificates
printf "deb https://plus-pkgs.nginx.com/ubuntu `lsb_release -cs` nginx-plus\n" | sudo tee /etc/apt/sources.list.d/nginx-plus.list

printf "Download the 90nginx file to /etc/apt/apt.conf.d\n"
sudo wget -q -O /etc/apt/apt.conf.d/90nginx https://cs.nginx.com/static/files/90nginx

printf "Update the repository information\n"
sudo apt-get update

printf "Install the nginx-plus package. Any older NGINX Plus package is automatically replaced.\n"
sudo apt-get install -y nginx-plus

printf "Enable the NGINX service\n"
sudo systemctl enable nginx

printf "Start the NGINX server\n"
sudo systemctl start nginx

printf "Display the NGINX status\n"
sudo systemctl status nginx

printf "End of script\n"
