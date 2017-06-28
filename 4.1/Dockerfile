FROM debian:jessie
ENV DEBIAN_FRONTEND noninteractive

#
# enable contrib repo
#
RUN sed -i 's/main/main contrib/g' /etc/apt/sources.list

#
# install varnish build deps
#
RUN apt-get update && apt-get install -y --no-install-recommends \
    automake \
    autotools-dev \
    build-essential \
    ca-certificates \
    curl \
    geoip-database-contrib \
    git \
    libedit-dev \
    libgeoip-dev \
    libjemalloc-dev \
    libmhash-dev \
    libncurses-dev \
    libpcre3-dev \
    libpcre3-dev \
    libtool \
    pkg-config \
    python-docutils \
    python-sphinx \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

#
# install varnish
#
ENV VARNISH_VERSION=4.1.7
ENV VARNISH_SHA256SUM=c52ee2f5d052a496f3700d8ac8eb4da45144779c863f09f7be70daec3cfed105
RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    curl -sfLO https://repo.varnish-cache.org/source/varnish-${VARNISH_VERSION}.tar.gz && \
    echo "${VARNISH_SHA256SUM} varnish-${VARNISH_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf varnish-${VARNISH_VERSION}.tar.gz && \
    cd varnish-${VARNISH_VERSION} && \
    ./autogen.sh && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf varnish-*

#
# install stock varnish module library
#
ENV VARNISHMODULES_VERSION=0.11.0
ENV VARNISHMODULES_SHA256SUM=147fd6d9b699fbfb668917e5848b143eb0a0ca0dd62d60d52a213133e3be0382

RUN cd /usr/local/src/ && \
    curl -sfL https://github.com/varnish/varnish-modules/archive/${VARNISHMODULES_VERSION}.tar.gz \
        -o varnish-modules-${VARNISHMODULES_VERSION}.tar.gz && \
    echo "${VARNISHMODULES_SHA256SUM} varnish-modules-${VARNISHMODULES_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf varnish-modules-${VARNISHMODULES_VERSION}.tar.gz && \
    cd varnish-modules-${VARNISHMODULES_VERSION} && \
    ./bootstrap && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf varnish-modules-${VARNISHMODULES_VERSION}* && \
    ldconfig

#
# install libvmod-dynamic
#
ENV LIBVMOD_DYNAMIC_VERSION=972f6e5063b80a8439a2ab631f4bcf5432dede77

RUN cd /usr/local/src/ && \
    git clone https://github.com/nigoroll/libvmod-dynamic.git && \
    cd libvmod-dynamic && \
    git reset --hard ${LIBVMOD_DYNAMIC_VERSION} && \
    ./autogen.sh && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf libvmod-dynamic && \
    ldconfig

#
# install libvmod-digest
#
ENV LIBVMOD_DIGEST_VERSION=1.0.1
ENV LIBVMOD_DIGEST_SHA256SUM=491c3e54ebca3340464a227732de7f475bc5136c0fdaab587b764dd77db376e2

RUN cd /usr/local/src/ && \
    curl -sfLO https://github.com/varnish/libvmod-digest/archive/libvmod-digest-${LIBVMOD_DIGEST_VERSION}.tar.gz && \
    echo "${LIBVMOD_DIGEST_SHA256SUM} libvmod-digest-${LIBVMOD_DIGEST_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf libvmod-digest-${LIBVMOD_DIGEST_VERSION}.tar.gz && \
    cd libvmod-digest-libvmod-digest-${LIBVMOD_DIGEST_VERSION} && \
    ./autogen.sh && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf libvmod-digest* && \
    ldconfig

#
# install libvmod-geoip
#
ENV LIBVMOD_GEOIP_VERSION=b4d72ecc23895d4a0e9b28655093861f0c85cb66

RUN cd /usr/local/src/ && \
    git clone https://github.com/varnish/libvmod-geoip.git && \
    cd libvmod-geoip && \
    git reset --hard ${LIBVMOD_GEOIP_VERSION} && \
    ./autogen.sh && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf libvmod-geoip && \
    ldconfig

# update geoip database
RUN /usr/sbin/geoip-database-contrib_update

# init
COPY init.sh /init.sh

RUN useradd -r -s /bin/false vcache
RUN mkdir /etc/varnish

ENV VARNISH_CONFIG  /etc/varnish/default.vcl
ENV VARNISH_STORAGE malloc,100m
ENV VARNISH_LISTEN  :80
ENV VARNISH_MANAGEMENT_LISTEN 127.0.0.1:6082

EXPOSE 80
EXPOSE 6082

CMD ["/init.sh"]
