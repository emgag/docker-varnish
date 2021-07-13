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
