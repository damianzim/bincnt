// vim: ts=4 sts=0 sw=0 noet
`default_nettype none
`timescale 1ns / 1ns

module bincnt_tb;
	reg [2:0] x;
	wire [1:0] y2b;
	wire [2:0] y3b;
	integer i;

	sorter2b srt2b (
		.x (x[1:0]),
		.y (y2b)
	);

	sorter3b srt3b (
		.x (x[2:0]),
		.y (y3b)
	);

	initial begin
		$dumpfile("bincnt_tb.vcd");
		$dumpvars(0, bincnt_tb);
	end

	initial begin
		$display("test: sorter2b, sorter3b");
		for (i = 0; i < 8; i = i + 1) begin
			x = i;
			#10;
		end
		$finish;
	end
endmodule

