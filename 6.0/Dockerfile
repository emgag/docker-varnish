FROM debian:stretch-slim
LABEL maintainer="Matthias Blaser <mb@emgag.com>"

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
ENV VARNISH_VERSION=6.0.1
ENV VARNISH_SHA256SUM=47f28e4da9d46f0e48fbe6067de734a01786081cda681bf2764f87914339f3b8

RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    curl -sfLO http://varnish-cache.org/_downloads/varnish-${VARNISH_VERSION}.tgz && \
    echo "${VARNISH_SHA256SUM} varnish-${VARNISH_VERSION}.tgz" | sha256sum -c - && \
    tar -xzf varnish-${VARNISH_VERSION}.tgz && \
    cd varnish-${VARNISH_VERSION} && \
    ./autogen.sh && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf varnish-*

#
# install stock varnish module library
#
ENV VARNISHMODULES_VERSION=0.15.0
ENV VARNISHMODULES_SHA256SUM=8c03a13c348127e11b317006b9206d0b94c79d3f775f337b8fa1da818cfd2482

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
ENV LIBVMOD_DYNAMIC_VERSION=0.4
ENV LIBVMOD_DYNAMIC_SHA256SUM=221ee019f0dd882a036d8eb8a57f92b5fd22d7c3a0fa74d89986b45e07e2ff26

RUN cd /usr/local/src/ && \
    curl -sfL https://github.com/nigoroll/libvmod-dynamic/archive/v${LIBVMOD_DYNAMIC_VERSION}.tar.gz \
        -o libvmod-dynamic-${LIBVMOD_DYNAMIC_VERSION}.tar.gz  && \
    echo "${LIBVMOD_DYNAMIC_SHA256SUM} libvmod-dynamic-${LIBVMOD_DYNAMIC_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf libvmod-dynamic-${LIBVMOD_DYNAMIC_VERSION}.tar.gz && \
    cd libvmod-dynamic-${LIBVMOD_DYNAMIC_VERSION} && \
    ./autogen.sh && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf libvmod-digest* && \
    ldconfig

#
# install libvmod-digest
#
ENV LIBVMOD_DIGEST_VERSION=1.0.2
ENV LIBVMOD_DIGEST_SHA256SUM=9cbe87f1990282ee25e06af5a19f2217638ce96cf3f155c0f5e7c79bad6afdea

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
ENV LIBVMOD_GEOIP_VERSION=1.0.3
ENV LIBVMOD_GEOIP_SHA256SUM=da4b26d26adfa2486035670a08969add40971ae24eeac9108fa3607594feadf7

RUN cd /usr/local/src/ && \
    curl -sfLO https://github.com/varnish/libvmod-geoip/archive/libvmod-geoip-${LIBVMOD_GEOIP_VERSION}.tar.gz && \
    echo "${LIBVMOD_GEOIP_SHA256SUM} libvmod-geoip-${LIBVMOD_GEOIP_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf libvmod-geoip-${LIBVMOD_GEOIP_VERSION}.tar.gz && \
    cd libvmod-geoip-libvmod-geoip-${LIBVMOD_GEOIP_VERSION} && \
    ./autogen.sh && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf libvmod-geoip* && \
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
