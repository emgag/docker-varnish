#!/bin/bash
exec varnishd \
    -j unix,user=vcache \
    -F \
    -f ${VARNISH_CONFIG} \
    -s ${VARNISH_STORAGE} \
    -a ${VARNISH_LISTEN} \
    -T ${VARNISH_MANAGEMENT_LISTEN} \
    ${VARNISH_DAEMON_OPTS}
