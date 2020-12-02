//------------------------------
// Module name: lab6task4
// Function: 	Create Simple echo 
// Creator:  Alyson Zhang
// Version:  1.0
// Date:     2 Dec 2020
//------------------------------
module Lab6Task4_top (
	MAX10_CLK1_50,		// system clock at 50MHz
	ADC_CS,		// ADC chip select - low active
	ADC_CLK,		// Serial symmetical clock at 1MHz 		
	ADC_DOUT,	// Serial data from ADC
	DAC_CS,		// DAC chip select - low active
	DAC_SCK,		// Serial symmetical clock at 1MHz 		
	DAC_SDI		// Serial data input to DAC
);

	input MAX10_CLK1_50;
	input ADC_DOUT;
	output ADC_CS, ADC_CLK;
	output DAC_CS, DAC_SCK, DAC_SDI;
	//output [6:0]  HEX0, HEX1, HEX2; 
	//output [7:0]  HEX3;
	
	wire  tick;					//  1 tick per sampling period
	wire [9:0] data_in; 		// data from ADC
	wire [9:0] data_out; 	// data to DAC and PWM
	wire	data_valid;			// high when converted data is available
	//wire [3:0]	bcd0, bcd1, bcd2, bcd3, bcd4;
 	
	clktick  GEN_10K (MAX10_CLK1_50, 1'b1, tick); // sampling at 50kHz
	

	spi2adc SPI_ADC_INTERFACE (
			.sysclk (MAX10_CLK1_50),
			.start (tick),
			.data_from_adc (data_in),
			.data_valid (data_valid),
			.adc_cs (ADC_CS),
			.adc_sck (ADC_CLK),
			.sdata_from_adc (ADC_DOUT));
			
	processor	SimpleEcho(MAX10_CLK1_50, data_in,data_out, data_valid);   // do some processing on the data
	
	spi2dac	SPI_DAC_INTERFACE (MAX10_CLK1_50, data_out, tick, 
									DAC_SDI, DAC_CS, DAC_SCK);	
	
endmodule