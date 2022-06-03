// vim: ts=4 sts=0 sw=0 noet
`default_nettype none
`timescale 1ns / 1ns

module bincnt7b3_tb;
	reg [6:0] x;
	wire [2:0] y;
	integer i;

	counter7b3 cnt7b3 (
		.x (x),
		.y (y)
	);

	initial begin
		$dumpfile("bincnt7b3_tb.vcd");
		$dumpvars(0, bincnt7b3_tb);
	end

	initial begin
		$display("test: counter7b3");
		for (i = 0; i < 128; i = i + 1) begin
			x = i;
			#10;
		end
		$finish;
	end
endmodule
