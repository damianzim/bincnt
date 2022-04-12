// vim: ts=4 sts=0 sw=0 noet
`default_nettype none
`timescale 1ns / 1ns

module sorter2b (
	input wire [1:0] x,
	output wire [1:0] y
);
	or (y[1], x[0], x[1]);
	and (y[0], x[0], x[1]);
endmodule

