`include "readCycle.v"
module testbench;
	wire latch, 
		 count, 
		 not_ce, 
		 not_oe,
		 reading;
	wire read, 
		 write,
		 reset,
		 clk;

	read_cycle dut (.latch(latch), .count(count), .not_ce(not_ce), .not_oe(not_oe), .reading(reading), .read(read), .write(write), .reset(reset), 
					 .clk(clk));
	test_it test (.latch(latch), .count(count), .not_ce(not_ce), .not_oe(not_oe), .reading(reading), .read(read), .write(write), .reset(reset), 
				  .clk(clk));
	initial
		begin
			$dumpfile("read_cycle.vcd");
			$dumpvars(1, dut);
		end
endmodule

module test_it (latch, count, not_ce, not_oe, reading, read, write, reset, clk);
	input   latch, 
		    count, 
		    not_ce, 
		    not_oe,
		    reading;
	output  read, 
		    write,
		    reset,
		    clk;

    reg read,
    	write,
    	reset,
    	clk;

    parameter period = 5,
    		  stimDelay = 10;

   	always 
   		#period clk = ~clk;

    initial
    	begin
    		clk = 0;
    		write = 0;
    	end

        initial
        	begin
        		#stimDelay reset = 1;
        		#stimDelay reset = 0;
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
                $finish;
        	end

endmodule
