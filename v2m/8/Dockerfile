FROM alpine:3.12.0

ARG RSNAPSHOT_VERSION=latest

# install rsnapshot
COPY configuration/rsnapshot.conf.default /etc/rsnapshot.conf
COPY imagescripts /usr/bin/rsnapshot.d

RUN apk upgrade --update && \
    if  [ "${RSNAPSHOT_VERSION}" = "latest" ]; \
      then apk add rsnapshot ; \
      else apk add "rsnapshot=${RSNAPSHOT_VERSION}" ; \
    fi && \
    mkdir -p /usr/bin/rsnapshot.d && \
    cp /etc/rsnapshot.conf /usr/bin/rsnapshot.d/rsnapshot.conf && \
    chmod ug+x /usr/bin/rsnapshot.d/*.sh && \
    rm -rf /var/cache/apk/* && rm -rf /tmp/*

ENV BACKUP_INTERVAL= \
    BACKUP_DIRECTORIES= \
    DELAYED_START= \
    RSNAPSHOT_HOURLY_TIMES= \
    RSNAPSHOT_DAILY_TIMES= \
    RSNAPSHOT_WEEKLY_TIMES= \
    RSNAPSHOT_MONTHLY_TIMES= \
    VOLUME_DIRECTORY=/snapshots

ENTRYPOINT ["/usr/bin/rsnapshot.d/docker-entrypoint.sh"]
VOLUME ["${VOLUME_DIRECTORY}"]
CMD ["rsnapshot"]
