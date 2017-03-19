#
# Salt Stack Salt Master Container
#

FROM alpine
ENTRYPOINT ["/bin/dumb-init", "--"]
EXPOSE 4505 4506
# Volumes
VOLUME ["/etc/salt/pki", "/var/cache/salt", "/var/logs/salt", "/etc/salt/master.d", "/srv/salt"]

ARG DUMB_INIT_VERSION=1.2.0

ENV UNIFI_PACKAGE_URL=${UNIFI_PACKAGE_URL} \
    DUMB_INIT_VERSION=${DUMB_INIT_VERSION}

ADD https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 /bin/dumb-init
COPY run.sh /usr/local/bin/run.sh

# Update System
RUN apk add --no-cache salt-master &&\
    chmod +x /bin/dumb-init /usr/local/bin/run.sh


CMD ["/usr/local/bin/run.sh"]
