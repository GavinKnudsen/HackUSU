module top(	input [1:0]op,
		input [1:0]register,
		input [7:0]data,
		input clk,
		input go,
		input program,
		input load, 
		output reg [7:0]q);
		
	reg [7:0] one;
	reg [7:0] two;
	reg [7:0] three;
	reg [7:0] four;
	reg [7:0] dataMan;
	reg [1:0] regMan;
	reg [1:0] opMan;
	wire [11:0] programData;
	reg [1:0] temp;
	reg [1:0] math;
	wire button;
	wire button2;


	program myProgram (.clk(clk), .go(button2), .rst(program), .data(programData)); 
	Debounce myButton (.b(go), .d(button), .clk(clk));
	Debounce loader (.b(load), .d(button2), .clk(clk));

	always @(posedge clk) begin
		if (~program) begin
			dataMan <= data;
			opMan <= op;
			regMan <= register;
		end
		else begin
			opMan <= programData[11:10];
			regMan <= programData[9:8];			
			dataMan <= programData[7:0];
		end
	end
	
	always @(posedge clk) begin
		temp = dataMan[7:6];
		math = dataMan[5:4];
		case(button)
			1'b1: case(opMan)
				2'b00:	case(regMan)
						2'b00:	one = dataMan;
						2'b01:	two = dataMan;
						2'b10: three = dataMan;
						2'b11: 	four = dataMan;
					endcase
				2'b01: case(regMan)
						2'b00: q = one;
						2'b01: q = two;
						2'b10: q = three;
						2'b11: q = four;
					endcase
				2'b10: case(temp)
						2'b00: case(regMan)
								2'b00:  one = one;
								2'b01: 	two = one;
								2'b10: 	three = one;
								2'b11: 	four = one;
							endcase
						2'b01: case(regMan)
								2'b00: one = two;
								2'b01: two = two;
								2'b10: three = two;
								2'b11: four = two;
							endcase	
						2'b10: case(regMan)
								2'b00: one = three;
								2'b01: two = three;
								2'b10: three = three;
								2'b11: four = three;
							endcase
						2'b11: case(regMan)
								2'b00: one = four;
								2'b01: two = four;
								2'b10: three = four;
								2'b11: four = four;
							endcase
					endcase
				2'b11: case(math)
						2'b00: case(regMan)
							2'b00: case(temp)
									2'b00:	one = one + one; 
									2'b01: 	one = one + two;
									2'b10: 	one = one + three;
									2'b11:  one = one + four;
								endcase
							2'b01: case(temp)
									2'b00: two = two + one;
									2'b01: two = two + two;
									2'b10: two = two + three;
									2'b11: two = two + four;
								endcase
							2'b10: case(temp)
									2'b00: three = three + one;
									2'b01: three = three + two;
									2'b10: three = three + three;
									2'b11: three = three + four;
								endcase
							2'b11: case(temp)
									2'b00: four = four + one;
									2'b01: four = four + two;
									2'b10: four = four + three;
									2'b11: four = four + four;
								endcase
							endcase
						2'b01: case(regMan)
							2'b00: case(temp)
									2'b00:	one = one - one; 
									2'b01: 	one = one - two;
									2'b10: 	one = one - three;
									2'b11:  one = one - four;
								endcase
							2'b01: case(temp)
									2'b00: two = two - one;
									2'b01: two = two - two;
									2'b10: two = two - three;
									2'b11: two = two - four;
								endcase
							2'b10: case(temp)
									2'b00: three = three - one;
									2'b01: three = three - two;
									2'b10: three = three - three;
									2'b11: three = three - four;
								endcase
							2'b11: case(temp)
									2'b00: four = four - one;
									2'b01: four = four - two;
									2'b10: four = four - three;
									2'b11: four = four - four;
								endcase
							endcase
						2'b10: case(regMan)
							2'b00: case(temp)
									2'b00:	one = one & one; 
									2'b01: 	one = one & two;
									2'b10: 	one = one & three;
									2'b11:  one = one & four;
								endcase
							2'b01: case(temp)
									2'b00: two = two & one;
									2'b01: two = two & two;
									2'b10: two = two & three;
									2'b11: two = two & four;
								endcase
							2'b10: case(temp)
									2'b00: three = three & one;
									2'b01: three = three & two;
									2'b10: three = three & three;
									2'b11: three = three & four;
								endcase
							2'b11: case(temp)
									2'b00: four = four & one;
									2'b01: four = four & two;
									2'b10: four = four & three;
									2'b11: four = four & four;
								endcase
							endcase
						2'b11: case(regMan)
							2'b00: case(temp)
									2'b00:	one = ~one; 
									2'b01: 	one = ~two;
									2'b10: 	one = ~three;
									2'b11:  one = ~four;
								endcase
							endcase
					endcase
				endcase
			1'b0: 	begin 
				q = q;
				one = one;
				two = two;
				three = three;
				four = four;
				end
			endcase
		end
endmodule

