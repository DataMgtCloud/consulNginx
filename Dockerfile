FROM datamgtcloud/baseconsul
MAINTAINER Changbing JI

COPY docker/consul.d/ /etc/consul.d/

# Install consul-template
RUN \
  curl -sL https://releases.hashicorp.com/consul-template/0.14.0/consul-template_0.14.0_linux_amd64.zip -o consul-template.zip && \
  unzip consul-template.zip && \
  mv consul-template /usr/local/bin/. && \
  rm consul-template.zip

# Install Nginx.
RUN \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

COPY startService.sh /etc/service/nginx/run/run.sh

#Setup Consul Template Files
COPY etc/consul-templates/ /etc/consul-templates/
ENV CT_FILE /etc/consul-templates/nginx.conf

#Setup Nginx File
ENV NX_FILE /etc/nginx/conf.d/app.conf

EXPOSE 80
EXPOSE 443

WORKDIR /etc/nginx

CMD ["/sbin/boot"]
