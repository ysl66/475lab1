`include "write_cycle.v"

module TestBench;

  wire latch, count, DE, nCS, nWE, writing, read, write, reset, clk;

  write_cycle wc1(latch, count, DE, nCS, nWE, writing, read, write, reset, clk);
  Tester tester1(latch, count, DE, nCS, nWE, writing, read, write, reset, clk);

  initial
  begin
  $dumpfile("wrtie_cycle_test1.vcd");
  $dumpvars(1,wc1);

  end

endmodule

module Tester(latch, count, DE, nCS, nWE, writing, read, write, reset, clk);
  input latch, count, DE, nCS, nWE, writing;
  output reg read, write, reset, clk;

  parameter period = 10;
  parameter stimDelay = 10;

  initial
  clk = 0;
  always
  begin
      #(period) clk <= ~clk;
  end

  always @(posedge clk)
	begin
		#stimDelay reset <= 1;
		#stimDelay write <= 1; read <= 0;
		#stimDelay reset <= 0;
		#(45*stimDelay);
    #stimDelay write <= 0; read <= 1;
    #(35*stimDelay);
    #stimDelay write <= 1; read <= 0;
    #(35*stimDelay);
    #stimDelay write <= 1; read <= 1;
    #(45*stimDelay);
		$finish;
	end
endmodule
