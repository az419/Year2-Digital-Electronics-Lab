//------------------------------
// Module name: times2 processor
// Function: Simply to pass input to output
// Creator:  Alyson Zhang
// Version:  1.1
// Date:     1 Dec 2020
//------------------------------

module processor (sysclk, data_in, data_out, data_valid);

	input				sysclk;		// system clock
	input [9:0]		data_in;		// 10-bit input data
	input 			data_valid;	// asserted when sample data is ready for processing
	output [9:0] 	data_out;	// 10-bit output data

	wire				sysclk;
	wire [9:0]		data_in;
	reg [9:0] 		data_out;
	wire [9:0]		x,y;

	parameter 		ADC_OFFSET = 10'd512;
	parameter 		DAC_OFFSET = 10'd512;

	assign x = data_in[9:0] - ADC_OFFSET;		// x is input in 2's complement
	
	// This part should include your own processing hardware 
	// ... that takes x to produce y
	// ... In this case, it is ALL PASS.
	assign y = 2*x;
	
	pulse_gen  PULSE (enable, data_valid, sysclk);
	
	//  Now clock y output with system clock
	always @(posedge sysclk)
		if (enable == 1'b1)
			data_out <=  y + DAC_OFFSET;
		
endmodule
	