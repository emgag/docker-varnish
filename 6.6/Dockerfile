# syntax=docker/dockerfile:experimental
FROM debian:buster-slim
LABEL maintainer="Matthias Blaser <mb@emgag.com>"

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
ENV VARNISH_VERSION=6.6.1
ENV VARNISH_SHA256SUM=ab1a6884332731f983c8dab675c636deb3883a206c8a0127a7c663af2422e628

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

##
## install libvmod-querystring
##
ENV LIBVMOD_QUERYSTRING_VERSION=2.0.2
ENV LIBVMOD_QUERYSTRING_SHA256SUM=f15a40419b8b5f77616b3adcbbee816577e2cd0376b33e14fdbe4474f2f29a01

# Fix build for >6.5 https://github.com/Dridi/libvmod-querystring/commit/fffe7583af018e9a9424139d9fc4080586cf3f90
COPY libvmod-querystring-VRT_re_fini.patch /usr/local/src

RUN cd /usr/local/src/ && \
    curl -sfLO https://github.com/Dridi/libvmod-querystring/releases/download/v${LIBVMOD_QUERYSTRING_VERSION}/vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz && \
    echo "${LIBVMOD_QUERYSTRING_SHA256SUM} vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz && \
    cd vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION} && \
    patch src/vmod_querystring.c < /usr/local/src/libvmod-querystring-VRT_re_fini.patch && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf vmod-querystring* && \
    rm /usr/local/src/libvmod-querystring-VRT_re_fini.patch && \
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
