/*
`include "write_cycle.v"
`include "readCycle.v"
`include "mux.v"
*/

module top (count, latch, de, n_ce, n_oe, n_we, read, write, clock, reset);
	output count, 
		   latch, 
		   de, 
		   n_ce, 
		   n_oe, 
		   n_we;

	input read, 
	      write, 
	      clock, 
	      reset;

	wire rcount, 
		rlatch, 
		n_oe;

	wire wcount, 
		wlatch, 
		de,  
		n_we;

	wire writing,
		reading;
		
	wire n_ce;
	
	assign n_ce = 0;

	write_cycle  wcycle  (.latch(wlatch), .count(wcount), .DE(de), .nWE(n_we), .writing(writing), .read(read), .write(write), 
								 .reset(reset), .clk(clock));
	read_cycle   rcycle  (.latch(rlatch), .count(rcount), .not_oe(n_oe), .reading(reading), .read(read), 
						  .write(writing), .reset(reset), .clk(clock));

	mux        latch_mux (.out(latch), .in1(wlatch), .in2(rlatch), .sel(~write));
	mux        count_mux (.out(count), .in1(wcount), .in2(rcount), .sel(~write));	


endmodule