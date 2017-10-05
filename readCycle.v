module read_cycle (latch, count, not_oe, reading, read, write, reset, clk);
	output latch, 
		   count,
		   not_oe,
		   reading;
		   
	input  read, 
		   write,
		   reset,
		   clk;

	reg   latch,
		   count,
		   not_oe,
			reading;

	reg [2:0] ps,
			  ns;

	parameter idle = 3'b000,
			  cycle_1 = 3'b001,
			  cycle_2 = 3'b010,
			  cycle_3 = 3'b011,
			  cycle_4 = 3'b100,
			  cycle_5 = 3'b101,
			  cycle_6 = 3'b110;


	//FSM for one write cycle
	always @(posedge clk)
		begin
			if (reset) ps = idle;
			else ps = ns;
			case (ps)
				idle: 
					begin
						reading = 0;
						latch = 0;
						count = 1;
						not_oe = 1;
						if (read == 1 && write == 0) ns = cycle_1;
						else ns = idle;
					end
				cycle_1:
					begin
						reading = 1;
						latch = 1;
						ns = cycle_2;
					end
				cycle_2:
					begin
						latch = 0;
						count = 0;
						ns = cycle_3;
					end
				cycle_3:
					begin
						not_oe = 0;
						ns = cycle_4;
					end
				cycle_4:
					begin
						count = 1;
						ns = cycle_5;
					end
				cycle_5:
					begin
						not_oe = 1;
						ns = cycle_6;
					end
				cycle_6:
					begin
						if (read == 1) ns = cycle_1;
						else ns = idle;
					end
			endcase
		end



endmodule

