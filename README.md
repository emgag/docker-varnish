# emgag/varnish

[![Build Status](https://api.travis-ci.org/emgag/docker-varnish.svg?branch=master)](https://travis-ci.org/emgag/docker-varnish)
[![Docker Pulls](https://img.shields.io/docker/pulls/emgag/varnish.svg)](https://hub.docker.com/r/emgag/varnish)
[![](https://images.microbadger.com/badges/image/emgag/varnish:6.0.4.svg)](https://microbadger.com/images/emgag/varnish:6.0.4 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/emgag/varnish:6.0.4.svg)](https://microbadger.com/images/emgag/varnish:6.0.4 "Get your own version badge on microbadger.com")

Docker [varnish](http://varnish-cache.org/) image used within EMGAG environments. Originally based on [newsdev/docker-varnish](https://github.com/newsdev) (not available anymore), but updated to recent varnish versions (6.0, 6.2 and 6.3), shipped with some additional [vmods](http://varnish-cache.org/vmods/#vmods) and better support for custom configuration.

Shipped VMODs:
* [libvmod-digest](https://github.com/varnish/libvmod-digest): HMAC, hash and base64 functions
* [libvmod-dynamic](https://github.com/nigoroll/libvmod-dynamic): Dynamic backend director
* [libvmod-querystring](https://github.com/Dridi/libvmod-querystring): Advanced query-string filtering. (**Introduced in 6.2 and 6.0.3-1**)
* [varnish-modules](https://github.com/varnish/varnish-modules): Official varnish vmod collection (cookie, header, saintmode, softpurge, tcp, var, vsthrottle, xkey)

## Supported tags and respective `Dockerfile` links

- [`6.3.0` (*6.3.0/Dockerfile*)](https://github.com/emgag/docker-varnish/blob/master/6.3/Dockerfile)
- [`6.2.1` (*6.2.1/Dockerfile*)](https://github.com/emgag/docker-varnish/blob/master/6.2/Dockerfile)
- [`6.0.4` (*6.0.4/Dockerfile*)](https://github.com/emgag/docker-varnish/blob/master/6.0/Dockerfile)

**Notes:** 
* Only 6.3, 6.2 and 6.0 are [versions supported by varnish](https://varnish-cache.org/releases/index.html) still maintained in this repo and available for download from dockerhub. For docs and code for versions 4.x and 5.x see [branch 4.1](https://github.com/emgag/docker-varnish/tree/4.1).

## Varnish

From [varnish-cache.org](https://varnish-cache.org/intro/index.html): _Varnish Cache is a web application accelerator also known as a caching HTTP reverse proxy. You install it in front of any server that speaks HTTP and configure it to cache the contents. Varnish Cache is really, really fast. It typically speeds up delivery with a factor of 300 - 1000x, depending on your architecture._

## How to use this image.

By default, varnish reads `/etc/varnish/default.vcl` on startup. Either copy your VCL file in your Dockerfile  
  
```
FROM emgag/varnish:6.3.0
COPY default.vcl /etc/varnish/default.vcl
```

or mount a volume containing the varnish configuration to `/etc/varnish`, e.g with a docker-compose file:

```
version: '3'
services:
  varnish:
    image: emgag/varnish:6.3.0
    volumes:
      - ./varnish:/etc/varnish
    ports:
      - "80:80"
```

Following environment variables can be used to customize the behaviour of the container:
* VARNISH_CONFIG (default: `/etc/varnish/default.vcl`): The VCL file read on startup.
* VARNISH_DAEMON_OPTS: Additional command line arguments for `varnishd`.
* VARNISH_LISTEN (default: `:80`): The TCP port to listen for incoming client connections. Make sure to also expose the new port if this value is modified.
* VARNISH_MANAGEMENT_LISTEN (default: `127.0.0.1:6082`): The TCP port to listen for management connections. See varnish documentation about [management interface authentication](https://varnish-cache.org/docs/trunk/users-guide/run_security.html) to setup a PSK.  
* VARNISH_STORAGE (default: `malloc,100m`): The cache backend and its configuration 

# License

View [license information](https://github.com/emgag/docker-varnish/blob/master/LICENSE) for the software contained in this image.

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/emgag/docker-varnish/issues).

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/emgag/docker-varnish/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
