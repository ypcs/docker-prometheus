FROM ypcs/debian:buster

ARG APT_PROXY

RUN /usr/lib/docker-helpers/apt-setup && \
    /usr/lib/docker-helpers/apt-upgrade && \
    apt-get --assume-yes install \
        curl && \
    /usr/lib/docker-helpers/apt-cleanup

RUN adduser --system --group prometheus

WORKDIR /tmp

RUN curl -O -fSL "https://github.com/prometheus/prometheus/releases/download/v2.17.1/prometheus-2.17.1.linux-amd64.tar.gz" && \
    tar xzf prometheus-*.linux-amd64.tar.gz && \
    mv prometheus-*.linux-amd64 /opt/prometheus && \
    rm -f *.tar.gz

WORKDIR /opt/prometheus

EXPOSE 9090

RUN mkdir -p /var/lib/prometheus/data && \
    ln -s /var/lib/prometheus/data && \
    chown prometheus:prometheus /var/lib/prometheus/data

USER prometheus
ENTRYPOINT ["/opt/prometheus/prometheus"]

RUN ls -lha && \
    ls -lha data
