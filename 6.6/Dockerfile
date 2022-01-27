# syntax=docker/dockerfile:experimental
FROM debian:buster-slim
LABEL maintainer="Matthias Blaser <mb@emgag.com>"
LABEL org.opencontainers.image.source = "https://github.com/emgag/docker-varnish"

#
# install varnish build deps
#
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        automake \
        autotools-dev \
        build-essential \
        ca-certificates \
        curl \
        git \
        libedit-dev \
        libgetdns-dev \
        libjemalloc-dev \
        libmhash-dev \
        libncurses-dev \
        libpcre3-dev \
        libtool \
        pkg-config \
        python3 \
        python3-docutils \
        python3-sphinx \
    && apt-get autoremove -y

#
# install varnish
#
ENV VARNISH_VERSION=6.6.2
ENV VARNISH_SHA256SUM=acb222e462dcdcc7ef3ba361345e5f99197477b0688b3a3631a1038af3705409

RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    curl -sfLO https://varnish-cache.org/_downloads/varnish-${VARNISH_VERSION}.tgz && \
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
ENV VARNISHMODULES_VERSION=0.18.0
ENV VARNISHMODULES_SHA256SUM=b226d3272bc92fb46175c417aca5a8c5f820baa2868961cae7d832b561fc159e

RUN cd /usr/local/src/ && \
    curl -sfLO https://github.com/varnish/varnish-modules/archive/${VARNISHMODULES_VERSION}.tar.gz && \
    echo "${VARNISHMODULES_SHA256SUM} ${VARNISHMODULES_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf ${VARNISHMODULES_VERSION}.tar.gz && \
    cd varnish-modules-${VARNISHMODULES_VERSION} && \
    ./bootstrap && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf ${VARNISHMODULES_VERSION} && \
    ldconfig

#
# install libvmod-dynamic
#
ENV LIBVMOD_DYNAMIC_BRANCH=master
ENV LIBVMOD_DYNAMIC_COMMIT=bbcd81578e33e5cee61a4b5e6c8a552ecb09e6d8

RUN cd /usr/local/src/ && \
    git clone -b ${LIBVMOD_DYNAMIC_BRANCH} https://github.com/nigoroll/libvmod-dynamic.git && \
    cd libvmod-dynamic && \
    git reset --hard ${LIBVMOD_DYNAMIC_COMMIT} && \
    ./autogen.sh && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf libvmod-dynamic && \
    ldconfig
#
##
## install libvmod-digest
##
ENV LIBVMOD_DIGEST_BRANCH=master
ENV LIBVMOD_DIGEST_COMMIT=1793bea9e9b7c7dce4d8df82397d22ab9fa296f0

RUN cd /usr/local/src/ && \
    git clone -b ${LIBVMOD_DIGEST_BRANCH} https://github.com/varnish/libvmod-digest.git && \
    cd libvmod-digest && \
    git reset --hard ${LIBVMOD_DIGEST_COMMIT} && \
    ./autogen.sh && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf libvmod-digest && \
    ldconfig

#
# install libvmod-querystring
#
ENV LIBVMOD_QUERYSTRING_VERSION=2.0.3
ENV LIBVMOD_QUERYSTRING_SHA256SUM=ec325d64241580ed136660f1d27cecd874b663431ac3abdb2d28e1ac6f4811e4

RUN cd /usr/local/src/ && \
    curl -sfLO https://github.com/Dridi/libvmod-querystring/releases/download/v${LIBVMOD_QUERYSTRING_VERSION}/vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz && \
    echo "${LIBVMOD_QUERYSTRING_SHA256SUM} vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz && \
    cd vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION} && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf vmod-querystring* && \
    ldconfig

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
