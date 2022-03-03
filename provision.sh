#!/bin/bash
# assign variables
ACTION=${1}
version="1.0.0"

function show_version() {
echo $version
}

function setup_env() {
#When executed without any arguments, the script will perform the following steps:
# Update all system packages
sudo yum update -y

# Install the Nginx software package
sudo amazon-linux-extras install nginx1.12 -y

# Configure nginx to automatically start at system boot up.
sudo chkconfig nginx on

# Copy the website documents from s3 to the web document root directory 
# (/usr/share/nginx/html).
sudo aws s3 cp s3://shai7384-assignment-webserver/index.html /usr/share/nginx/html/index.html

#Start the Nginx service.
sudo service nginx start
}

#If the user starts the script with a -r or --remove argument, the script will perform the 
function uninstall_nginx(){
# Stop the Nginx service.
sudo service nginx stop

#Delete the files in the website document root directory (/usr/share/nginx/html).
sudo rm /usr/share/nginx/html/index.html

# Uninstall the Nginx software package (yum remove nginx -y).
sudo yum remove nginx -y
}
function display_help() {
cat << EOF
Usage: ${0} {-r|--remove|-h|--help|-v|--version} 
OPTIONS:
-r | --remove Removes file and stops nginx and uninstall
-h | --help Display the command help
-v | --version   Shows the current version of file
If no argument then install nginx software
EOF
}
case "$ACTION" in
-h|--help)
display_help
;;
-r|--remove)
uninstall_nginx
;;
-v|--version)
show_version "$version"
;;
*)
setup_env
esac
