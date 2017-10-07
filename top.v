/*
`include "write_cycle.v"
`include "readCycle.v"
`include "mux.v"
*/

module top (count, latch, de, n_ce, n_oe, n_we, rst, n_rst, n_de, read, write, clock, reset);
	output count, 
		   latch, 
		   de, 
		   n_ce, 
		   n_oe, 
		   n_we,
			rst,
			n_rst,
			n_de;

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
		
	wire n_ce, rst, n_rst, n_de;
	
	

	write_cycle  wcycle  (.latch(wlatch), .count(wcount), .DE(de), .nWE(n_we), .writing(writing), .read(read), .write(write), 
								 .reset(reset), .clk(clock));
	read_cycle   rcycle  (.latch(rlatch), .count(rcount), .not_oe(n_oe), .reading(reading), .read(read), 
						  .write(writing), .reset(reset), .clk(clock));

	mux        latch_mux (.out(latch), .in1(wlatch), .in2(rlatch), .sel(~writing));
	mux        count_mux (.out(count), .in1(wcount), .in2(rcount), .sel(~writing));

	assign n_ce = 0;
	assign rst = reset;
	assign n_rst = ~reset;
	assign n_de = ~de;


endmodule