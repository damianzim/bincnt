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

module mux2b (
	input wire [1:0] x,
	input wire s,
	output wire y
);
	wire [1:0] l1;
	and (l1[0], x[0], ~s);
	and (l1[1], x[1], s);
	or (y, l1[0], l1[1]);
endmodule

module counter7b3 (
	input wire [6:0] x,
	output wire [2:0] y
);
	wire [1:3] I;
	wire [1:4] H;

	wire [3:1] c2l1;
	wire [2:1] c2l2;

	wire [0:3] Q;

	wire [2:1] sl1;
	wire [2:1] sl2;

	wire [2:1] c1l1;
	wire [2:1] c1l2;

	sorter3b srtI (
		.x (x[6:4]),
		.y (I)
	);
	sorter4b srtH (
		.x (x[3:0]),
		.y (H)
	);

	// C2 - Layer 1
	and (c2l1[1], I[3], H[1]);
	and (c2l1[2], I[2], H[2]);
	and (c2l1[3], I[1], H[3]);
	// C2 - Layer 2
	or (c2l2[1], c2l1[1], c2l1[2]);
	or (c2l2[2], c2l1[3], H[4]);
	// C2
	or (y[2], c2l2[1], c2l2[2]);

	// Q
	assign Q = {~I[1], I[1]&(~I[2]), I[2]&(~I[3]), I[3]};

	// C1 - Layer 1
	and (c1l1[1], H[2], ~H[4]);
	and (c1l1[2], H[1], ~H[3]);
	// C1 - Layer 2
	mux2b mux2c1a (
		.x ({Q[0], Q[2]}),
		.s (c1l1[1]),
		.y (c1l2[1])
	);
	mux2b mux2c1b (
		.x ({Q[1], Q[3]}),
		.s (c1l1[2]),
		.y (c1l2[2])
	);
	// C1
	or (y[1], c1l2[1], c1l2[2]);

	// S - Layer 1
	and (sl1[1], H[1], ~H[2]);
	and (sl1[2], H[3], ~H[4]);
	// S - Layer 2
	or (sl2[1], sl1[1], sl1[2]);

	// mistake in the article (circuit): sl2[2] = Q[2]|Q[3]
	or (sl2[2], Q[1], Q[3]);
	// S
	xor (y[0], sl2[2], sl2[1]);
endmodule
