vcl 4.0;

import cookie;
import digest;
import directors;
import dynamic;
import header;
import saintmode;
import purge;
import std;
import tcp;
import var;
import vsthrottle;
import xkey;

backend default {
    .host = "127.0.0.1";
    .port = "8080";
}

sub vcl_recv {
    std.log("you can't stop the signal!");
}