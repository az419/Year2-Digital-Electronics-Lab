//-----------------------------------------------------------------------------------
//Module name: task2_top

//Function: Top level module for Lab 3 Task2 to display 10 switches on a 3 7-seg displays

//Creator: Alyson Zhang

//Version: 2.0

//Date: 3 Nov 2020
//-----------------------------------------------------------------------------------
module task2_top(
	SW,
	HEX0,
	HEX1,
	HEX2
);

	input  [9:0] SW;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	
	
	hex_to_7segSW9		SEG0(HEX0, SW[3:0]);
	hex_to_7segSW9		SEG1(HEX1, SW[7:4]);
	hex_to_7segSW9		SEG2(HEX2, {2'b00,SW[9:8]});
	
endmodule
