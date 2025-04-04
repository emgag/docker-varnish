# syntax=docker/dockerfile:experimental
FROM debian:bookworm-slim
LABEL org.opencontainers.image.source = "https://github.com/emgag/docker-varnish"

#
# install varnish build deps
#
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        autoconf-archive \
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
        libpcre2-8-0 \
        libpcre2-dev \
        libpcre3-dev \
        libreadline-dev \
        libtool \
        liburing-dev \
        libxxhash-dev \
        pkg-config \
        python3 \
        python3-docutils \
        python3-sphinx \
    && apt-get autoremove -y

#
# install varnish
#
ENV VARNISH_VERSION=7.6.2
ENV VARNISH_SHA256SUM=385c610ecc63dcfeb53d76f47cc465e89ebe27da2c09226f9861c4fa8e9d2c9a
ENV VARNISHSRC=/usr/local/src/varnish-${VARNISH_VERSION}

RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    curl -sfLO https://varnish-cache.org/_downloads/varnish-${VARNISH_VERSION}.tgz && \
    echo "${VARNISH_SHA256SUM} varnish-${VARNISH_VERSION}.tgz" | sha256sum -c - && \
    tar -xzf varnish-${VARNISH_VERSION}.tgz && \
    rm varnish-${VARNISH_VERSION}.tgz && \
    cd varnish-${VARNISH_VERSION} && \
    ./autogen.sh && \
    ./configure && \
    make install

#
# install stock varnish module library
#
ENV VARNISHMODULES_VERSION=0.25.0
ENV VARNISHMODULES_SHA256SUM=5112835be86f2cfc0eebd718326a9aef49bd6aadf6f7ed43690fd99cd0d31996

RUN cd /usr/local/src/ && \
    curl -sfLO https://github.com/varnish/varnish-modules/archive/${VARNISHMODULES_VERSION}.tar.gz && \
    echo "${VARNISHMODULES_SHA256SUM} ${VARNISHMODULES_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf ${VARNISHMODULES_VERSION}.tar.gz && \
    cd varnish-modules-${VARNISHMODULES_VERSION} && \
    ./bootstrap && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm ${VARNISHMODULES_VERSION}.tar.gz \
    rm -rf varnish-modules-${VARNISHMODULES_VERSION} && \
    ldconfig

#
# install libvmod-dynamic
#
ENV LIBVMOD_DYNAMIC_BRANCH=master
ENV LIBVMOD_DYNAMIC_COMMIT=740f5aa499a67112639d3c2d11fe44e26d0d4437

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
ENV LIBVMOD_DIGEST_VERSION=1.0.3
ENV LIBVMOD_DIGEST_SHA256SUM=872fd18aa672609195c0dc128ca29e1a1b3a11924c71a34ed7fd956f9177111c

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
ENV LIBVMOD_QUERYSTRING_VERSION=2.0.4
ENV LIBVMOD_QUERYSTRING_SHA256SUM=965cd64edcb1c46dd88573b6e5da52b93cf21bbf0e482acff72f47d82bf866ed

RUN cd /usr/local/src/ && \
    curl -sfLO https://git.sr.ht/~dridi/vmod-querystring/refs/download/vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}/vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz && \
    echo "${LIBVMOD_QUERYSTRING_SHA256SUM} vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz" | sha256sum -c - && \
    tar -xzf vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION}.tar.gz && \
    cd vmod-querystring-${LIBVMOD_QUERYSTRING_VERSION} && \
    ./configure && \
    make install && \
    cd /usr/local/src && \
    rm -rf vmod-querystring* && \
    ldconfig

#
# install slash storage engines
#
#ENV SLASH_BRANCH=master
#ENV SLASH_COMMIT=c250c9cd3cbb9b751aa230ca6b72c2937b5ff656
#
#RUN cd /usr/local/src/ && \
#    git clone -b ${SLASH_BRANCH} https://gitlab.com/uplex/varnish/slash.git && \
#    cd slash && \
#    git reset --hard ${SLASH_COMMIT} && \
#    ./bootstrap && \
#    make check && \
#    make install && \
#    cd /usr/local/src && \
#    rm -rf slash && \
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
