module Lab7Challenge3_top(
	MAX10_CLK1_50,
	SW,
	D,
	A,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	DAC_CS,
	DAC_SDI,
	DAC_SCK
);

	input		[9:0]	SW;
	input				MAX10_CLK1_50;
	output	[9:0]	D;
	output	[6:0] HEX0,HEX1,HEX2,HEX3,HEX4;
	output	DAC_CS, DAC_SDI, DAC_SCK;
	output	[9:0]	A;
	
	wire		[3:0] BCD0, BCD1, BCD2, BCD3, BCD4;
	wire				tick_50k;
	wire		[26:0]freq_inter;
	wire		[15:0]freq;
	
	
	clktick			Cascaded_Counter(MAX10_CLK1_50, 1'b1, tick_50k);
	
	assign enable = tick_50k;
	//assign load = tick_50k;
	
	ncounter			CountedVal(MAX10_CLK1_50,enable,SW,A);
	//ROM1				ROM_out(SW,MAX10_CLK1_50,D);
	ROM1				ROM_out(A,tick_50k,D);
	spi2dac			DAC_Result(MAX10_CLK1_50,D,tick_50k,DAC_SDI,DAC_CS,DAC_SCK);
	
	assign	freq_inter = SW*17'd100000;
	assign	freq = freq_inter[26:11];
	
	bin2bcd_16		Converter(freq,BCD0, BCD1, BCD2, BCD3, BCD4);
	hex_to_7seg		SEG0(HEX0, BCD0);
	hex_to_7seg		SEG1(HEX1, BCD1);
	hex_to_7seg		SEG2(HEX2, BCD2);
	hex_to_7seg		SEG3(HEX3, BCD3);
	hex_to_7seg		SEG4(HEX4, BCD4);	

endmodule