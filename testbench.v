`timescale 1ns/1ps

module testbench ();
   
   // DECLARE SIGNALS
   reg clk;     // "reg" type signals are  controlled
   reg [1:0] register;  // by the testbench
   reg [7:0] data;  
   reg [1:0] op;
   reg go;
   wire [7:0] q;
   reg program;

   integer clk_count = 0;   
   
   // INITIAL SIGNAL CONFIGURATION:
   initial begin
      clk = 0;      
      register   = 0;
      data   = 0;
      op = 0;
      go = 0;
      program = 1;
   end

   // GENERATE CLOCK:
   initial forever #10 clk = ~clk;
   
   // CREATE STIMULI:
   always @(posedge clk) begin
      register <= $random();
      data <= $random();
      op = op + 1;
      go = $random();
   end

   

   // WRITE OUTPUT TO CONSOLE:
   
   always @(posedge clk) begin
      $write("clk:   %d", clk_count);
      $write("\treg:   %b, %d", register, register);
      $write("\tdata:   %b, %d", data, data);
      $write("\tgo:  %b", go);
      $write("\top:  %b, %d", op, op);
      $write("\tq:   %b, %d", q, q);
      $write("\n");
   end

   // DEFINE WHEN TO TERMINATE SIMULATION:
   always @(posedge clk) begin
      clk_count <= clk_count + 1;
      if (clk_count == 20) begin
	 $finish;
      end
   end
   
   top DUT (.clk(clk), .register(register), .data(data), .go(go),.load(go), .op(op),.program(program), .q(q));
   
endmodule // testbench
