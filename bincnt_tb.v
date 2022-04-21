// vim: ts=4 sts=0 sw=0 noet
`default_nettype none
`timescale 1ns / 1ns

module bincnt_tb;
	reg [3:0] x;
	wire [1:0] y2b;
	wire [2:0] y3b;
	wire [3:0] y4b;
	integer i;

	sorter2b srt2b (
		.x (x[1:0]),
		.y (y2b)
	);

	sorter3b srt3b (
		.x (x[2:0]),
		.y (y3b)
	);

	sorter4b srt4b (
		.x (x[3:0]),
		.y (y4b)
	);

	initial begin
		$dumpfile("bincnt_tb.vcd");
		$dumpvars(0, bincnt_tb);
	end

	initial begin
		$display("test: sorter2b, sorter3b, sorter4b");
		for (i = 0; i < 16; i = i + 1) begin
			x = i;
			#10;
		end
		$finish;
	end
endmodule

