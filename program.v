
module program(	input  clk,
		input  go,
		input  rst,
		output reg[11:0]data);

	reg [3:0] select;
	reg [3:0] limit;

	always @(posedge clk) begin
		limit = 4'b1000;
		if (rst) begin
			select <= 4'b0000;
		end
		if (go) begin
			if (select < limit) begin
				select <= select + 1'b1;
			end
			else begin
				select <= 4'b0000;
			end
		end
		else begin
			select <= select;
		end
	end

	always @(posedge clk)
		case(select)
			4'b0000:	data = 12'b000000000001;
			4'b0001:	data = 12'b100001000000;
			4'b0010:	data = 12'b010000000000;
			4'b0011:	data = 12'b010100000000;
			4'b0100:	data = 12'b110001000000;
			4'b0101:	data = 12'b110100010000;
			4'b0110:	data = 12'b010000000000;
			4'b0111: 	data = 12'b010100000000;
		endcase
endmodule
