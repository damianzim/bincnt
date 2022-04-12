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

module sorter3b (
	input wire [2:0] x,
	output wire [2:0] y
);
	wire [1:0] l1;
	wire l2;
	sorter2b s_2_1_0 (
		.x (x[2:1]),
		.y (l1)
	);
	sorter2b s_1_0 (
		.x ({l1[0], x[0]}),
		.y ({l2, y[0]})
	);
	sorter2b s_2_1_1 (
		.x ({l1[1], l2}),
		.y (y[2:1])
	);
endmodule

