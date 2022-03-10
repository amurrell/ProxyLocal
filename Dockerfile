# Set the base image to ubuntu:16.04
FROM ubuntu:20.04

# File Author / Maintainer
LABEL maintainer "Angela Murrell <me@angelamurrell.com>"

# Update the repository and install nginx and php7.0
RUN apt-get update && \
  apt-get install -y nano && \
  apt-get install -y curl && \
  apt-get install -y nginx && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# export var for nano to work in command line
ENV TERM xterm

# Set workdir
WORKDIR /var/www/

# Add site directory
RUN mkdir /var/www/site

# Copy site configuration files from the current directory
COPY nginx-sites/ /etc/nginx/sites-available/

# Copy a configuration file from the current directory
ADD nginx.proxy.conf /etc/nginx/sites-available/
#ADD nginx-sites/nginx.docker.syringe.recoverybrands.com.conf /etc/nginx/sites-available/

# Remove symbolic link to default enabled nginx site in sites-enabled
RUN rm /etc/nginx/sites-enabled/default
RUN rm /etc/nginx/sites-available/default

# Make Symbolic link to enable the docker example site
RUN ln -s /etc/nginx/sites-available/nginx.proxy.conf /etc/nginx/sites-enabled/

# Append "daemon off;" to the configuration file
RUN mv /etc/nginx/nginx.conf /var/www/site/nginx-original.conf
COPY nginx.conf /etc/nginx/

# Adjust www-data
RUN usermod -u 1000 www-data

# Set the default command to execute when creating a new container
# The following runs FPM and removes all its extraneous log output on top of what your app outputs to stdout
CMD service nginx start
