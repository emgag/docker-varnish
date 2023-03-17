vcl 4.0;

import blob;
import bodyaccess;
import cookie;
import debug;
import digest;
import directors;
import dynamic;
import header;
import proxy;
import purge;
import querystring;
import saintmode;
import std;
import tcp;
import unix;
import var;
import vsthrottle;
import vtc;
import xkey;

backend default {
    .host = "127.0.0.1";
    .port = "8080";
}

sub vcl_recv {
    std.log("you can't stop the signal!");
}
