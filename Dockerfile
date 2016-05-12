# Consul server

FROM datamgtcloud/baseconsul
MAINTAINER Changbing JI

COPY docker/consul.d/ /etc/consul.d/

# Make server data persistent
VOLUME /data
RUN \
  mkdir /data/consul && \
  ln -s /data/consul /opt/datamgt/config/srv/consul

EXPOSE 80

CMD ["/sbin/boot"]
