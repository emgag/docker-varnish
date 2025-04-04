## 2025-04-05

* Return from hiatus.
* Bump [vmod-querystring](https://git.sr.ht/~dridi/vmod-querystring) to 2.0.4 and use updated location.
* Add 6.0.13-1 tag with updated vmod-querystring.
* Add [7.6](https://varnish-cache.org/releases/rel7.6.2.html) release.
* Add [7.7](https://varnish-cache.org/releases/rel7.7.0.html) release.
* EOL'd version 7.3, 7.4 and 7.3.

## 2024-05-30

* Add [7.5](https://varnish-cache.org/releases/rel7.5.0.html) release.
* Update to 6.0.13, 7.3.2, 7.4.3 and 7.5 to address [VSV00014 Varnish HTTP/2 Broke Window Attack](https://varnish-cache.org/security/VSV00014.html#vsv00014).
 
## 2023-12-28

* Add [7.4](https://varnish-cache.org/releases/rel7.4.0.html#rel7-4-0) release.
* Update to 6.0.12, 7.3.1 and 7.4.2 to address [VSV00013 Varnish HTTP/2 Rapid Reset Attack](https://varnish-cache.org/security/VSV00013.html#vsv00013).
* Switch base images to debian:bookworm-slim.
* EOL'd version 7.2. 

## 2023-08-18

* Update [vmod-digest](https://github.com/varnish/libvmod-digest) to address [VSV00012 Base64 decoding vulnerability in vmod-digest](https://varnish-cache.org/security/VSV00012.html), updated images are 7.3.0-1, 7.2.1-1 and 6.0.11-1.
* Switch 6.0 image to debian:buster-slim because Debian Stretch is EOL'd now.

## 2023-03-24

* Add [7.3.0](https://varnish-cache.org/releases/rel7.3.0.html#rel7-3-0)
* Keep built varnish source directory in image to allow building vmods which require it to be around
* Remove dockerhub image builds
* EOL'd version 7.1. 

## 2022-11-10

* Update to 6.0.11, 7.1.2 and 7.2.1 to address [VSV00010 Varnish Request Smuggling Vulnerability](https://varnish-cache.org/security/VSV00010.html#vsv00010) and [VSV00011 Varnish HTTP/2 Request Forgery Vulnerability](https://varnish-cache.org/security/VSV00011.html#vsv00011)

## 2022-09-16

* Add [7.2.0](https://varnish-cache.org/releases/rel7.2.0.html#rel7-2-0)
* EOL'd version 7.0. 

## 2022-09-06

* Update to 7.0.3 and 7.1.1 to address [VSV00009 Varnish Denial of Service Vulnerability](https://varnish-cache.org/security/VSV00009.html#vsv00009)

## 2022-03-15

* Add [7.1.0](https://varnish-cache.org/releases/rel7.1.0.html#rel7-1-0)
* EOL'd version 6.6. 

## 2022-01-27

* Update to 7.0.2, 6.6.2 and 6.0.10 to address [VSV00008 Varnish HTTP/1 Request Smuggling Vulnerability](https://varnish-cache.org/security/VSV00008.html)

## 2021-11-26

* Bump [6.0 to 6.0.9](https://varnish-cache.org/releases/rel6.0.9.html#rel6-0-9)
* Bump [7.0 to 7.0.1](https://varnish-cache.org/releases/rel7.0.1.html#rel7-0-1)
* Bump [libvmod-querystring to 2.0.3](https://github.com/Dridi/libvmod-querystring/releases/tag/v2.0.3)
* Rebuild 6.6 (6.6.1-2) to bump libvmod-querystring 

## 2021-10-01

* Build container images for multiple architectures (Thanks to @danielcompton):
  * linux/amd64
  * linux/arm64 (untested)
* Add 7.0.0.
* Add rebuilds for older versions (6.0.8-1, 6.6.1-1).
* EOL'd version 6.5.

## 2021-07-13

* Update to 6.6.1, 6.5.2 and 6.0.8 to address [VSV00007 Varnish HTTP/2 Request Smuggling Attack](http://varnish-cache.org/security/VSV00007.html)

## 2021-03-17

* Add 6.6.0
* Switch back to [official varnish-modules release](https://github.com/varnish/varnish-modules) again for 6.5.1-1 ([0.17.1](https://github.com/varnish/varnish-modules/releases/tag/0.17.1)) and 6.6.0 ([0.18.0](https://github.com/varnish/varnish-modules/releases/tag/0.18.0)). This also addresses [VSV00006 varnish-modules Denial of Service](https://varnish-cache.org/security/VSV00006.html).
* Bump libvmod-dynamic version for 6.5.1-1  
* EOL'd version 6.4.

## 2021-01-04

* Update to 6.5.1 and 6.0.7

## 2020-09-22

* Add 6.5.0 build
    * Switch to [nigoroll/varnish-modules](https://github.com/nigoroll/varnish-modules) varnish-modules fork
    * Removed vmod softpurge
* EOL'd version 6.3 

## 2020-09-06

* Upload new images to Github Container Registry as well 

## 2020-03-18

* Add 6.4.0 build
* Drop 6.2 support as it's no longer supported by varnish

## 2020-02-05

* Update to 6.3.2, 6.2.3 and 6.0.6 to address [VSV00005 Varnish HTTP Proxy Protocol V2 Denial of Service](https://varnish-cache.org/security/VSV00005.html)

## 2019-10-21

* Update to 6.3.1, 6.2.2 and 6.0.5 to address [VSV00004 (Workspace information leak)](http://varnish-cache.org/security/VSV00004.html#vsv00004)

## 2019-10-10

* Final update for 4.1 branch with working builds for 4.1.x, 5.0.x, 5.1.x and 5.2.x and reupload latest image for each release (but w/o shipped geoip databases)
* Clarify documentation about available tags

## 2019-10-09

* Initial support for 6.3.0
* Add libgetdns for advanced DNS features in vmod-dynamic (6.3)
* Remove deprecated and unmaintained tags from docker hub (6, 6.0, 4.\*, 5.\*, latest, testing), reuploaded latest 4.1 image (4.1.11)
* Add CHANGELOG
