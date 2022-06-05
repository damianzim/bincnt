// vim: ts=4 sts=0 sw=0 noet
`default_nettype none
`timescale 1ns / 1ns

module binmul16b_tb;
	reg [15:0] x;
	reg [15:0] y;
	wire [31:0] z;

	multiplier16b mul16b (
		.x (x),
		.y (y),
		.z (z)
	);

	initial begin
		$dumpfile("binmul16b_tb.vcd");
		$dumpvars(0, binmul16b_tb);
	end

	initial begin
		$display("test: multiplier16b");
		x = 16'hdeaf;
		y = 16'h0003;
		#10;
		$finish;
	end
endmodule
