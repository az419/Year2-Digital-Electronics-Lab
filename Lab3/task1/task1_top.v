//-----------------------------------------------------------------------------------
//Module name: task1_top

//Function: Top level module for Lab 3 Task1 to display 4 switch on a 7-seg display

//Creator: Alyson Zhang

//Version: 1.0

//Date: 3 Nov 2020
//-----------------------------------------------------------------------------------
module task1_top(
	SW,
	HEX0
);

	input [3:0] SW;
	output [6:0] HEX0;
	
	hex_to_7seg		SEG0(HEX0, SW[3:0]);
	
endmodule