/*
`include "top.v"
`include "dflipflop.v"
*/

module sram (GPIO_0, SW, CLOCK_50);
	output [35:0] GPIO_0;

	input [9:0] SW;
	input       CLOCK_50; //50 MHz clock -> 1 clock cycle = 20 ns

	top t (.count(GPIO_0[14]), .latch(GPIO_0[15]), .de(GPIO_0[16]), .n_ce(GPIO_0[17]), .n_oe(GPIO_0[28]), .n_we(GPIO_0[29]), 
		   .read(SW[0]), .write(SW[1]), .clock(CLOCK_50), .reset(SW[9]));

endmodule