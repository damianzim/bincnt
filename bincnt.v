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

module sorter4b (
	input wire [3:0] x,
	output wire [3:0] y
);
	wire [3:0] l1;
	wire [1:0] l2;
	sorter2b s_3_2 (
		.x (x[3:2]),
		.y (l1[3:2])
	);
	sorter2b s_1_0 (
		.x (x[1:0]),
		.y (l1[1:0])
	);
	sorter2b s_3_1 (
		.x ({l1[3], l1[1]}),
		.y ({y[3], l2[0]})
	);
	sorter2b s_2_0 (
		.x ({l1[2], l1[0]}),
		.y ({l2[1], y[0]})
	);
	sorter2b s_2_1 (
		.x (l2),
		.y (y[2:1])
	);
endmodule

