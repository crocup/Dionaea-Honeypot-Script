FROM debian:buster-slim as install

RUN apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    check \
    cmake \
    cython3 \
    git \
    libcurl4-openssl-dev \
    libemu-dev \
    libev-dev \
    libglib2.0-dev \
    libloudmouth1-dev \
    libnetfilter-queue-dev \
    libnl-3-dev \
    libpcap-dev \
    libssl-dev \
    libtool \
    libudns-dev \
    python3-dev \
    --no-install-recommends

# get latest dionaea from source
RUN git clone https://github.com/DinoTools/dionaea.git /opt/dionaea-git

WORKDIR /opt/dionaea-git/build
RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/dionaea .. && \
    make && \
    make install

FROM debian:buster-slim
RUN apt-get update && apt-get -y install \
    ca-certificates \
    curl \
    libemu2 \
    libev4 \
    libglib2.0-0 \
    libloudmouth1-0 \
    libnetfilter-queue1 \
    libnl-3-200 \
    libpcap0.8 \
    libpython3.5 \
    libssl-dev \
    libtool \
    libudns0 \
    procps \
    python3 \
    python3-bson \
    python3-sqlalchemy \
    python3-yaml \
    fonts-liberation \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=install /opt/dionaea /opt/dionaea

EXPOSE 21
EXPOSE 80
EXPOSE 443
EXPOSE 445
EXPOSE 11211
EXPOSE 1443
EXPOSE 123/udp

RUN mkdir -p /var/dionaea/binaries \
    /var/dionaea/bitstreams \
    /var/dionaea/logs \
    /var/dionaea/roots/ftp/root \
    /var/dionaea/roots/http/root

RUN rm -rf /opt/dionaea/etc/dionaea/services-enabled && \
    rm -rf /opt/dionaea/etc/dionaea/ihandlers-enabled

COPY config/dionaea.cfg /opt/dionaea/etc/dionaea/dionaea.cfg
COPY config/ihandlers /opt/dionaea/etc/dionaea/ihandlers-enabled
COPY config/services /opt/dionaea/etc/dionaea/services-enabled

CMD /opt/dionaea/bin/dionaea -l info -L '*' -c /opt/dionaea/etc/dionaea/dionaea.cfg
