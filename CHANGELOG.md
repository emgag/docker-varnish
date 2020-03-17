## 2020-03-18

* Add 6.4.0 build
* Drop 6.2 support as it's not longer supported by varnish

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