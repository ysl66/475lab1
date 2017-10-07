module clock_divider (clock, divided_clock);
	input 			 clock;
	output 	       divided_clock;
	reg 		[31:0] divided_clocks;
		
	initial
		divided_clocks <= 0;
		
	always @(posedge clock) begin
	
		divided_clocks <= divided_clocks + 1;
	end
	
	assign divided_clock = divided_clocks[15];
endmodule 