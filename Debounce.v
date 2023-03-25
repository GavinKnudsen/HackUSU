module Debounce(
	input b,
	input clk,
	output reg d);

	integer state = 2'b00;
	
	always @(posedge clk) begin

		case(state)
			2'b00: begin
				d <= 0;
				if (b == 1) begin
					state = 2'b01;
				end
				else begin
					state = 2'b00;
				end
			end
			2'b01: begin
				if (b == 1) begin
					state = 2'b10;
				end 
				else begin
					state = 2'b00;
				end
			end
			2'b10: begin
				if (b == 0) begin
					state = 2'b11;
				end
				else begin
					state = 2'b10;
				end
			end
			2'b11: begin
				if (b == 0) begin
					state = 2'b00;
					d <= 1;
				end
				else begin
					state = 2'b10;
				end
			end
		endcase
	end
endmodule
