//-----------------------------------------------------------------------------------
//Module name: Lab4task2_top

//Function: Top level module for Lab 4 Task2 to build a 16-bit counter with a converter converting to BCD and then display in 5 LEDs

//Creator: Alyson Zhang

//Version: 1.0n

//Date: 17 Nov 2020
//-----------------------------------------------------------------------------------

module lab4Task2_top(
		MAX10_CLK1_50,
		KEY,
		HEX0,
		HEX1,
		HEX2,
		HEX3,
		HEX4


);

		input 	[1:0] KEY;
		input		MAX10_CLK1_50;
		output	[6:0] HEX0;
		output	[6:0] HEX1;
		output	[6:0] HEX2;
		output	[6:0] HEX3;
		output	[6:0] HEX4;
		
		wire [15:0] X;
		wire [3:0]	BCD0, BCD1, BCD2, BCD3, BCD4;
		wire reset, enable;
		wire tick;
		
		assign reset = !KEY[0];
		//assign enable = !KEY[1];

		clktick			Cascaded_Counter(MAX10_CLK1_50, 1'b1, tick);
		
		assign enable = tick && !KEY[1];
		
		counter_16		Counter(MAX10_CLK1_50, enable, reset, X);	
		bin2bcd_16		Converter(X, BCD0, BCD1, BCD2, BCD3, BCD4);
		hex_to_7seg		SEG0(HEX0, BCD0);
		hex_to_7seg		SEG1(HEX1, BCD1);
		hex_to_7seg		SEG2(HEX2, BCD2);
		hex_to_7seg		SEG3(HEX3, BCD3);
		hex_to_7seg		SEG4(HEX4, BCD4);
		
endmodule		