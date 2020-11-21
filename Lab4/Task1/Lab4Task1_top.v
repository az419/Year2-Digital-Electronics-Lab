//-----------------------------------------------------------------------------------
//Module name: task1_top

//Function: Top level module for Lab 4 Task1 to build a 4-bit counter with reset, count enable buttons

//Creator: Alyson Zhang

//Version: 1.0

//Date: 16 Nov 2020
//-----------------------------------------------------------------------------------

module Lab4Task1_top(
		KEY,
		HEX0
);


		input [1:0] KEY;
		output [6:0] HEX0;
		
		wire [3:0] count;
		wire enable;
		wire reset, clock;
		
		assign reset = !KEY[0];
		assign clock = KEY[1];
		assign enable = 1'b1;
		
		
		counter_4		SEG0(clock, enable, reset, count);		// reset KEY[0], clock KEY[1]
		hex_to_7seg		SEG1(HEX0, count);
		
endmodule