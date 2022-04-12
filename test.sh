# vim: ts=4 sts=0 sw=0 noet
#!/usr/bin/env bash -e
set -xe

iverilog -Wall -g2012 -o bincnt bincnt_tb.v bincnt.v
vvp bincnt

