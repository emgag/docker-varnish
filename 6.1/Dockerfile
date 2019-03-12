FROM debian:stretch-slim
LABEL maintainer="Matthias Blaser <mb@emgag.com>"

#
# install varnish build deps
#
RUN apt-get update && apt-get install -y --no-install-recommends \
    automake \
    autotools-dev \
    build-essential \
    ca-certificates \
    curl \
    git \
    libedit-dev \
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
ENV VARNISH_VERSION=6.1.1
ENV VARNISH_SHA256SUM=e0ee7c88a8149d8890b26fd9e1d909859ea895a39ca188d76a96869cff87c93d

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
ENV VARNISHMODULES_BRANCH=6.1
ENV VARNISHMODULES_COMMIT=c1c9b6ff4652c34aeff68f209d983be684caeb32

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
ENV LIBVMOD_DYNAMIC_COMMIT=9da11d19d58942d4bf5843ed559796ec1bee8f24

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
# install libvmod-querystring
#
ENV LIBVMOD_QUERYSTRING_VERSION=2.0
ENV LIBVMOD_QUERYSTRING_SHA256SUM=c883ac31c322a853bafb34406797833eaa46254b7ce020a6d5cafb9bd9dbbe1e

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
