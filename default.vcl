# varnish main vcl with includes
vcl 4.0;
import std;

# main.vcl
include "/etc/varnish/main.vcl";
