//-----------------------------------------------------------------------------------
//Module name: Lab4Task3_top

//Function: Top level module for Lab 4 Task3 to build a 7-bit LFSR and create PRBS to display on LEDs in HEX

//Creator: Alyson Zhang

//Version: 1.0

//Date: 20 Nov 2020
//-----------------------------------------------------------------------------------
module Lab4Task3_top(
	KEY,
	HEX0,
	HEX1
);

	input  [1:0] KEY;
	output [6:0] HEX0;
	output [6:0] HEX1;
	
	wire	clk;
	wire [7:1] PRBS;
	//wire [6:0] X;
	wire [3:0] BCD0, BCD1;
	
	assign clk = !KEY[1];
	
	lfsr7				PRBS_result(PRBS, clk);
	hex_to_7seg		SEG0(HEX0, PRBS[4:1]);
	hex_to_7seg		SEG1(HEX1, {1'b0, PRBS[7:5]});
	
endmodule