`timescale 1ns/1ps
module alu(	input  [3:0]Rx,
		input  [3:0]Ry,
		input  [1:0]op,
		input  clk,
		output reg [3:0]q);

	always @(posedge clk) begin
		case(op)
			2'b00:	q <= Rx + Ry;
			2'b01: 	q <= Rx - Ry;
			2'b10: 	q <= Rx & Ry;
			2'b11: 	q <= ~Rx;
		endcase
	end

endmodule
