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
ENV VARNISH_VERSION=6.5.1
ENV VARNISH_SHA256SUM=11964c688f9852237c99c1e327d54dc487549ddb5f0f5aa7996e521333d7cdb5

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
ENV VARNISHMODULES_BRANCH=master
ENV VARNISHMODULES_COMMIT=4d6593c2c97ecbabd3bd68203bace9cdbd6e960c

RUN cd /usr/local/src/ && \
    git clone -b ${VARNISHMODULES_BRANCH} https://github.com/nigoroll/varnish-modules.git && \
    cd varnish-modules && \
    git reset --hard ${VARNISHMODULES_COMMIT} && \
    ./bootstrap && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf varnish-modules && \
    ldconfig

#
# install libvmod-dynamic
#
ENV LIBVMOD_DYNAMIC_BRANCH=master
ENV LIBVMOD_DYNAMIC_COMMIT=acc08dc62101a05c0e84a0a6fb7ce653502a5a9d

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
ENV LIBVMOD_DIGEST_BRANCH=6.3
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
