/*
`include "top.v"
`include "dflipflop.v"
*/

module sram (GPIO_0, LEDR, SW, CLOCK_50);
	output [35:0] GPIO_0;
	output [9:0] LEDR;

	input [9:0] SW;
	input       CLOCK_50; //50 MHz clock -> 1 clock cycle = 20 ns
	
	wire         system_clk;

	
	clock_divider cd (.clock(CLOCK_50), .divided_clock(system_clk));
	top t (.count(GPIO_0[14]), .latch(GPIO_0[15]), .de(GPIO_0[16]), .n_ce(GPIO_0[17]), .n_oe(GPIO_0[28]), .n_we(GPIO_0[29]), .rst(GPIO_0[30]), .n_rst(GPIO_0[31]), .n_de(GPIO_0[32]),
		   .read(SW[0]), .write(SW[1]), .clock(system_clk), .reset(SW[9]));
	assign LEDR[0] = GPIO_0[14];
	assign LEDR[1] = GPIO_0[15];
	assign LEDR[2] = GPIO_0[16];
	assign LEDR[3] = GPIO_0[17];
	assign LEDR[4] = GPIO_0[28];
	assign LEDR[5] = GPIO_0[29];
	assign LEDR[6] = GPIO_0[31];
	assign LEDR[7] = GPIO_0[32];
	assign LEDR[8] = 0;
	assign LEDR[9] = 0;
   
	//assign LEDR[9:0] = 10'b0000000000;
endmodule