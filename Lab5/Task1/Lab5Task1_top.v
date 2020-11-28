//-----------------------------------------------------------------------------------
//Module name: Lab5task1_top

//Function: Top level module for Lab 5 Task1 to build a Digital to Analogue Converter using PWM

//Creator: Alyson Zhang

//Version: 1.0

//Date: 23 Nov 2020
//-----------------------------------------------------------------------------------
module Lab5Task1_top(
		MAX10_CLK1_50,
		SW,
		PWM_OUT,
		HEX0,
		HEX1,
		HEX2,
		HEX3,
		HEX4
);

		input		[9:0] SW;
		input		MAX10_CLK1_50;
		output	PWM_OUT;
		output	[6:0] HEX0;
		output	[6:0] HEX1;
		output	[6:0] HEX2;
		output	[6:0] HEX3;
		output	[6:0] HEX4;
		
		wire 			max, load;
		wire 			tick_50k;
		wire [3:0]  BCD0, BCD1, BCD2, BCD3, BCD4;
		
		clktick			Cascaded_Counter(MAX10_CLK1_50, 1'b1, tick_50k);
		
		//assign max = 10'd999;
		assign load = tick_50k;
		
		
		pwm				PWMsig(MAX10_CLK1_50, SW, load, PWM_OUT, 10'd999);
		bin2bcd_16		Converter({6'b000000, SW}, BCD0, BCD1, BCD2, BCD3, BCD4);
		hex_to_7seg		SEG0(HEX0, BCD0);
		hex_to_7seg		SEG1(HEX1, BCD1);
		hex_to_7seg		SEG2(HEX2, BCD2);
		hex_to_7seg		SEG3(HEX3, BCD3);
		hex_to_7seg		SEG4(HEX4, BCD4);
		
endmodule
		
		
		
		