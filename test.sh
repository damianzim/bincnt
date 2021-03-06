# vim: ts=4 sts=0 sw=0 noet
#!/usr/bin/env bash -e
set -xe

mkdir -p bin

iverilog -Wall -g2012 -o bin/bincnt bincnt_tb.v bincnt.v
vvp bin/bincnt

iverilog -Wall -g2012 -o bin/bincnt7b3 bincnt7b3_tb.v bincnt.v
vvp bin/bincnt7b3

iverilog -Wall -g2012 -o bin/binmul16b binmul16b.v bincnt.v binmul16b_tb.v
vvp bin/binmul16b

python3 gentestmul.py
iverilog -Wall -g2012 -o bin/testmul binmul16b.v bincnt.v testmul_tb.v
vvp bin/testmul
