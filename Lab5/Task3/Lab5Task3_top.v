//-----------------------------------------------------------------------------------
//Module name: Lab5task2_top

//Function: Top level module for Lab 5 Task3 to build a simple triangular wave generator

//Creator: Alyson Zhang

//Version: 1.0

//Date: 26 Nov 2020
//-----------------------------------------------------------------------------------
module Lab5Task3_top(
		MAX10_CLK1_50,
		SW,
		PWM_OUT,
		HEX0,
		HEX1,
		HEX2,
		HEX3,
		HEX4,
		DAC_CS,
		DAC_SDI,
		DAC_SCK
);

		input		MAX10_CLK1_50;
		input		[9:0] SW;
		output	PWM_OUT;
		output	DAC_CS, DAC_SDI, DAC_SCK;
		output	[6:0] HEX0;
		output	[6:0] HEX1;
		output	[6:0] HEX2;
		output	[6:0] HEX3;
		output	[6:0] HEX4;
		
		wire 			max, load;
		wire 			tick_50k;
		wire	[3:0] BCD0, BCD1, BCD2, BCD3, BCD4;
		wire	[9:0]	count;
		
		clktick			Cascaded_Counter(MAX10_CLK1_50, 1'b1, tick_50k);
		
		//assign max = 10'd999;
		assign load = tick_50k;
		assign enable = tick_50k;
		
		
		//counter_10		CountedVal(MAX10_CLK1_50,enable,count);
		ncounter			CustomisedVal(MAX10_CLK1_50,enable,SW,count);
		pwm				PWMsig(MAX10_CLK1_50, count, load, PWM_OUT, 10'd999);
		bin2bcd_16		Converter({6'b000000, count}, BCD0, BCD1, BCD2, BCD3, BCD4);
		hex_to_7seg		SEG0(HEX0, BCD0);
		hex_to_7seg		SEG1(HEX1, BCD1);
		hex_to_7seg		SEG2(HEX2, BCD2);
		hex_to_7seg		SEG3(HEX3, BCD3);
		hex_to_7seg		SEG4(HEX4, BCD4);
		spi2dac			DAC_Result(MAX10_CLK1_50,count,tick_50k,DAC_SDI,DAC_CS,DAC_SCK);
		
endmodule