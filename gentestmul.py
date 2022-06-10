#!/usr/bin/env python3
# vim: ts=4 sts=0 sw=0 tw=100 noet

import random
import sys

N = 1000

HEADER = """
// vim: ts=4 sts=0 sw=0 noet
`default_nettype none
`timescale 1ns / 1ns

module testmul_tb;
  reg [15:0] x [{}:0];
  reg [15:0] y [{}:0];
  reg [15:0] xin;
  reg [15:0] yin;
  reg [31:0] zmul;
  wire [31:0] z;
  integer i;

  multiplier16b mul16b (
	.x (xin),
	.y (yin),
	.z (z)
  );

  initial begin
	$dumpfile("testmul_tb.vcd");
	$dumpvars(0, testmul_tb);
  end

"""

FOOTER = """
  initial begin
	$display("test: testmul");
	for (i = 0; i < $size(x); i = i + 1) begin
	  xin = x[i];
	  yin = y[i];
	  zmul = xin * yin;
	  #10;
	  if (zmul != z)
		$display("xin=0x%4H yin=0x%4H got=%8H expected=%8H", xin, yin, z, zmul);
	end
	$finish;
  end
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
