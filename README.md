# emgag/varnish

[![Build Status](https://api.travis-ci.org/emgag/docker-varnish.svg?branch=master)](https://travis-ci.org/emgag/docker-varnish)

Docker [varnish](http://varnish-cache.org/) image used within EMGAG environments. Originally based on [newsdev/docker-varnish](https://github.com/newsdev/docker-varnish), but updated to recent varnish versions (4.1 and 5.0), added some additional [vmods](http://varnish-cache.org/vmods/#vmods) and support for additional configuration. 

Shipped modules (vmods):
* [varnish-modules](https://github.com/varnish/varnish-modules): Official varnish vmod collection (cookie,header,saintmode,softpurge,tcp,var,vsthrottle,xkey)
* [libvmod-dynamic](https://github.com/nigoroll/libvmod-dynamic): Dynamic backend director
* [libvmod-digest](https://github.com/varnish/libvmod-digest): HMAC, hash and base64 functions
* [libvmod-geoip](https://github.com/varnish/libvmod-geoip): GeoIP lookup support

## Supported tags and respective `Dockerfile` links

- [`4.1.5`, `4.1`, `4`,  (*4.1.5/Dockerfile*)](https://github.com/emgag/docker-varnish/blob/master/4.1/Dockerfile)
- [`5.0.0`, `5.0`, `5`, `latest` (*5.0.0/Dockerfile*)](https://github.com/emgag/docker-varnish/blob/master/5.0/Dockerfile)

## Varnish

From [varnish-cache.org](http://varnish-cache.org/intro/index.html#intro): _Varnish Cache is a web application accelerator also known as a caching HTTP reverse proxy. You install it in front of any server that speaks HTTP and configure it to cache the contents. Varnish Cache is really, really fast. It typically speeds up delivery with a factor of 300 - 1000x, depending on your architecture._

## How to use this image.

TBD (sorry)

# License

View [license information](https://github.com/emgag/docker-varnish/blob/master/LICENSE) for the software contained in this image.

# Supported Docker versions

This image is supported on Docker version 1.13.1.

Support for older versions (down to 1.6) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/emgag/docker-varnish/issues).

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/emgag/docker-varnish/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
