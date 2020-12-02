module Lab6Task2_top(
	input			MAX10_CLK1_50,
	input	[9:0]	SW,
	input 		ADC_DOUT,
	output		DAC_CS, DAC_SDI, DAC_SCK,
	output		data_valid,
	output 		ADC_CS, ADC_CLK,
	output[6:0] HEX0,HEX1,HEX2,
	output[7:0] HEX3

);

	wire			tick_50k;
	wire	[3:0] BCD0, BCD1, BCD2, BCD3, BCD4;
	wire  [9:0] data_in;
	wire  [15:0] voltage;
	
	
	clktick			Cascaded_Counter(MAX10_CLK1_50, 1'b1, tick_50k);
	
	spi2dac			DAC_Result(MAX10_CLK1_50,SW,tick_50k,DAC_SDI,DAC_CS,DAC_SCK);
	spi2adc			ADC_Result(MAX10_CLK1_50,tick_50k,data_in,data_valid,ADC_CS, ADC_CLK,ADC_DOUT);
	
	assign voltage = data_in * 6'd33 / 6'd10;
	
	//bin2bcd_16 		BCD_CONVERTER ({6'b0,data_in}, BCD0, BCD1, BCD2, BCD3, BCD4);
	bin2bcd_16 		BCD_CONVERTER (voltage, BCD0, BCD1, BCD2, BCD3, BCD4);

	hex_to_7seg 	DISP0 	(HEX0, BCD0);
	hex_to_7seg 	DISP1 	(HEX1, BCD1);
	hex_to_7seg 	DISP2 	(HEX2, BCD2);
	hex_to_7seg 	DISP3 	(HEX3[6:0], BCD3);
	hex_to_7seg_DP decimal 	(HEX3[7]);
	
endmodule

	