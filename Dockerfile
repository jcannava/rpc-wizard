from ubuntu:14.04

ENV HOME /var/www

# Generate Locale Files
RUN locale-gen en_US.UTF-8

# Export Locale
ENV LANG en_US.UTF-8

# Set the env variable DEBIAN_FRONTEND to non-interactive
ENV DEBIAN_FRONTEND noninteractive

RUN apt-mark hold initscripts udev plymouth mountall
RUN apt-get update
RUN apt-get install -y build-essential git-core python-setuptools software-properties-common python-software-properties
RUN git clone https://github.com/jcannava/rpc-wizard /var/www/html

# Install Setup nginx to serve app
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx
RUN rm -rf /var/lib/apt/lists
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN rm -rf /var/www/html/index.nginx-debian.html
RUN chown -R www-data:www-data /var/lib/nginx
COPY nginx_default /etc/nginx/sites-available/default

# Define Default Command
CMD ["nginx"]

# Expose Ports
EXPOSE 80
