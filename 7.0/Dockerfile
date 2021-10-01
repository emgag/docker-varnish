# syntax=docker/dockerfile:experimental
FROM debian:bullseye-slim
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
        libpcre2-dev \
        libpcre2-8-0 \
        libtool \
        pkg-config \
        python3 \
        python3-docutils \
        python3-sphinx \
    && apt-get autoremove -y

#
# install varnish
#
ENV VARNISH_VERSION=7.0.0
ENV VARNISH_SHA256SUM=8c7a5c0b1f36bc70bcbc9a48830835249e895fb8951f0363110952148cbae087

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
ENV VARNISHMODULES_VERSION=0.19.0
ENV VARNISHMODULES_SHA256SUM=6ecda159c9a08453d76bb6ebc888251deae6c5d88e622fa10614c5fad3fca254

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
ENV LIBVMOD_DYNAMIC_COMMIT=5eb7529d89e08cdc59a639569a9ddeb94e4f7fe7

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
# install libvmod-digest
#
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
ENV LIBVMOD_QUERYSTRING_VERSION=2.0.2
ENV LIBVMOD_QUERYSTRING_SHA256SUM=f15a40419b8b5f77616b3adcbbee816577e2cd0376b33e14fdbe4474f2f29a01

# Fix build for >6.5 https://github.com/Dridi/libvmod-querystring/commit/fffe7583af018e9a9424139d9fc4080586cf3f90
COPY libvmod-querystring-VRT_re_fini.patch /usr/local/src

# Fix build for 7.0 https://github.com/Dridi/libvmod-querystring/pull/49/commits/9202445bb1a9509411ead4e16da2d721d67eb86c
COPY libvmod-querystring-Adjust-to-new-VRE-api.patch /usr/local/src

RUN cd /usr/local/src/ && \
    curl -sfLO https://github.com/Dridi/libvmod-querystring/releases/download/v${LIBVMOD_QUERYSTRING_VERSION}/vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz && \
    echo "${LIBVMOD_QUERYSTRING_SHA256SUM} vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz && \
    cd vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION} && \
    patch src/vmod_querystring.c < /usr/local/src/libvmod-querystring-VRT_re_fini.patch && \
    patch -p1 < /usr/local/src/libvmod-querystring-Adjust-to-new-VRE-api.patch && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf vmod-querystring* && \
    rm /usr/local/src/libvmod-querystring-VRT_re_fini.patch && \
    rm /usr/local/src/libvmod-querystring-Adjust-to-new-VRE-api.patch && \
    ldconfig

#
# install libvdp-pesi
#
ENV LIBVDP_PESI_BRANCH=6.6
ENV LIBVDP_PESI_COMMIT=a4357ee796e48f6ecba4b37da4e804752511403b

# TODO: include when build from source is fixed
# configure-Error:
# checking for Varnish... 7.0.0
# configure: error: Varnish version trunk or higher is required.
#
## Fix build for 7.0 https://gitlab.com/uplex/varnish/libvdp-pesi/-/merge_requests/1
#COPY libvdp-pesi-compile.patch /usr/local/src
#
#RUN cd /usr/local/src/ && \
#    # build also requires built varnish sources to compile
#    curl -sfLO https://varnish-cache.org/_downloads/varnish-${VARNISH_VERSION}.tgz && \
#    echo "${VARNISH_SHA256SUM} varnish-${VARNISH_VERSION}.tgz" | sha256sum -c - && \
#    tar -xzf varnish-${VARNISH_VERSION}.tgz && \
#    cd varnish-${VARNISH_VERSION} && \
#    ./autogen.sh && \
#    ./configure && \
#    make && \
#    cd .. && \
#    # build libvdp-pesi
#    git clone -b ${LIBVDP_PESI_BRANCH} https://code.uplex.de/uplex-varnish/libvdp-pesi.git && \
#    cd libvdp-pesi && \
#    git reset --hard ${LIBVDP_PESI_COMMIT} && \
#    patch -p1 < /usr/local/src/libvdp-pesi-compile.patch && \
#    ln -s ../varnish-${VARNISH_VERSION}/m4 m4 && \
#    ./autogen.sh && \
#    ./configure VARNISHSRC=/usr/local/src/varnish-${VARNISH_VERSION} && \
#    make && \
#    make check && \
#    make install && \
#    cd /usr/local/src && \
#    rm -rf libvdp-pesi && \
#    rm /usr/local/src/libvdp-pesi-compile.patch && \
#    rm -rf varnish-* && \
#    ldconfig

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
