#!/usr/bin/env python3
# vim: ts=4 sts=0 sw=0 tw=100 noet

import random
import sys

N = 1000

HEADER = """// vim: ts=4 sts=0 sw=0 noet
`default_nettype none
`timescale 1ns / 1ns

module testmul_tb;
\treg [15:0] x [{}:0];
\treg [15:0] y [{}:0];
\treg [15:0] xin;
\treg [15:0] yin;
\treg [31:0] zmul;
\twire [31:0] z;
\tinteger i;

\tmultiplier16b mul16b (
\t\t.x (xin),
\t\t.y (yin),
\t\t.z (z)
\t);

\tinitial begin
\t\t$dumpfile("testmul_tb.vcd");
\t\t$dumpvars(0, testmul_tb);
\tend

"""

FOOTER = """
\tinitial begin
\t\t$display("test: testmul");
\t\tfor (i = 0; i < $size(x); i = i + 1) begin
\t\t\txin = x[i];
\t\t\tyin = y[i];
\t\t\tzmul = xin * yin;
\t\t\t#10;
\t\t\tif (zmul != z)
\t\t\t\t$display("xin=0x%4H yin=0x%4H got=%8H expected=%8H", xin, yin, z, zmul);
\t\tend
\t\t$finish;
\tend
endmodule
"""

def main():
	random.seed(0)
	with open("./testmul_tb.v", "w") as fw:
		fw.write(HEADER.format(N - 1, N - 1))
		for i in range(N):
			x, y = random.randrange(0x10000), random.randrange(0x10000)
			fw.write(f"\tassign x[{i}] = 16'h{x:04x}; assign y[{i}] = 16'h{y:04x};\n")
		fw.write(FOOTER)

if __name__ == "__main__":
	sys.exit(main())
