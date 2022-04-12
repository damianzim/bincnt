// vim: ts=4 sts=0 sw=0 noet
`default_nettype none
`timescale 1ns / 1ns

module bincnt_tb;
	reg [1:0] x;
	wire [1:0] y;
	integer i;

	sorter2b srt2b (
		.x (x[1:0]),
		.y (y[1:0])
	);

	initial begin
		$dumpfile("bincnt_tb.vcd");
		$dumpvars(0, bincnt_tb);
	end

	initial begin
		$display("test: sorter2b");
		for (i = 0; i < 4; i = i + 1) begin
			x = i;
			#10;
		end
		$finish;
	end
endmodule

