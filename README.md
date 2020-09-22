# emgag/varnish

![build](https://github.com/emgag/docker-varnish/workflows/build/badge.svg)
![MIT](https://img.shields.io/github/license/emgag/docker-varnish)

Docker [varnish](http://varnish-cache.org/) image used within EMGAG environments. Originally based on [newsdev/docker-varnish](https://github.com/newsdev) (not available anymore), but updated to recent varnish versions (6.0, 6.4 and 6.5), shipped with some additional [vmods](http://varnish-cache.org/vmods/#vmods) and better support for custom configuration.

Shipped VMODs:
* [libvmod-digest](https://github.com/varnish/libvmod-digest): HMAC, hash and base64 functions
* [libvmod-dynamic](https://github.com/nigoroll/libvmod-dynamic): Dynamic backend director
* [libvmod-querystring](https://github.com/Dridi/libvmod-querystring): Advanced query-string filtering. (**Introduced in 6.2 and 6.0.3-1**)
* [varnish-modules](https://github.com/nigoroll/varnish-modules): Fork of official varnish vmod collection (tcp, vsthrottle, xkey, saintmode, bodyaccess, header, var)

## Registries

* Github Container Registry: [ghcr.io/emgag/varnish](https://github.com/orgs/emgag/packages/container/varnish) (Images starting from 6.4.0, 6.3.2 and 6.0.6)
* Dockerhub: [emgag/varnish](https://hub.docker.com/r/emgag/varnish) (Archive)

## Supported tags and respective `Dockerfile` links

* [`6.5.0` (*6.4.0/Dockerfile*)](https://github.com/emgag/docker-varnish/blob/master/6.5/Dockerfile), based on debian:buster-slim.
* [`6.4.0` (*6.4.0/Dockerfile*)](https://github.com/emgag/docker-varnish/blob/master/6.4/Dockerfile), based on debian:buster-slim.
* [`6.0.6` (*6.0.6/Dockerfile*)](https://github.com/emgag/docker-varnish/blob/master/6.0/Dockerfile), based on debian:stretch-slim.

**Notes:** 
* This repository does **not contain shorthand tags** (e.g. latest, 6, 6.1, etc.), just fully qualified versions corresponding to shipped varnish version and occasionally an additional package version (e.g. 6.0.3-1) if something in the image changed within a varnish release. This is because it might happen that a specific vmod stopped being supported for whatever reason and removing it will break future releases, which is outside of our control (e.g. old releases contained libvmod-geoip, which isn't supported anymore).
* **Only 6.5, 6.4 and 6.0** are [versions supported by varnish](https://varnish-cache.org/releases/index.html), maintained in this repo and available for download from github container registry and dockerhub.
* The most recent of the **unsupported** legacy versions, 4.1.11, 5.0.0. 5.1.3 and 5.2.1 are available from dockerhub as well. 
* For docs and code for versions 4.x and 5.x see [branch 4.1](https://github.com/emgag/docker-varnish/tree/4.1).  

## Varnish

From [varnish-cache.org](https://varnish-cache.org/intro/index.html): _Varnish Cache is a web application accelerator also known as a caching HTTP reverse proxy. You install it in front of any server that speaks HTTP and configure it to cache the contents. Varnish Cache is really, really fast. It typically speeds up delivery with a factor of 300 - 1000x, depending on your architecture._

## How to use this image.

By default, varnish reads `/etc/varnish/default.vcl` on startup. Either copy your VCL file in your Dockerfile  
  
```
FROM ghcr.io/emgag/varnish:6.5.0
COPY default.vcl /etc/varnish/default.vcl
```

or mount a volume containing the varnish configuration to `/etc/varnish`, e.g with a docker-compose file:

```
version: '3'
services:
  varnish:
    image: ghcr.io/emgag/varnish:6.5.0
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
