`include "top.v"

module testbench();
	wire count, 
		   latch, 
		   de, 
		   n_ce, 
		   n_oe, 
		   n_we;

	wire read, 
	      write, 
	      clock, 
	      reset;

	top dut (.count(count), .latch(latch), .de(de), .n_ce(n_ce), .n_oe(n_oe), .n_we(n_we), .read(read), .write(write), .clock(clock), .reset(reset));
	test_it aTester (.count(count), .latch(latch), .de(de), .n_ce(n_ce), .n_oe(n_oe), .n_we(n_we), .read(read), .write(write), .clock(clock), .reset(reset));

	initial
		begin
			$dumpfile("top.vcd");
			$dumpvars(1, dut);
		end
endmodule 

module test_it (count, latch, de, n_ce, n_oe, n_we, read, write, clock, reset);
	input count, 
		   latch, 
		   de, 
		   n_ce, 
		   n_oe, 
		   n_we;

	output read, 
	      write, 
	      clock, 
	      reset;

	reg   read, 
	      write, 
	      clock, 
	      reset;

    parameter period = 5,
    		  stimDelay = 10;

   	always 
   		#period clock = ~clock;

    initial
    	begin
    		clock = 1;
    		read = 0;
    		write = 0;
    	end
   	initial
    	begin
		               reset = 1;
    		#stimDelay reset = 0; write = 1;
    		#stimDelay write = 0;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay read = 1;
    		#stimDelay read = 0;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
    		#stimDelay;
            $finish;
    	end
endmodule 