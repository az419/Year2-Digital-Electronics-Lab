//------------------------------
// Module name: allpass processor
// Function: Simply to pass input to output
// Creator:  Peter Cheung
// Version:  1.1
// Date:     24 Jan 2014
//------------------------------

module processor(sysclk, data_in, data_out, data_valid);

	input				sysclk;		// system clock
	input [9:0]		data_in;		// 10-bit input data
	input 			data_valid;	// asserted when sample data is ready for processing
	output [9:0] 	data_out;	// 10-bit output data


	wire				sysclk;
	wire 	[9:0]		data_in;
	wire				wren;
	reg 	[9:0] 	data_out;
	wire 	[9:0]		x,y;
	wire	[9:0]		q;
	wire				wrreq,rdreq,full;
	wire				fifo_state;


	parameter 		ADC_OFFSET = 10'd512;
	parameter 		DAC_OFFSET = 10'd512;

	assign x = data_in[9:0] - ADC_OFFSET;		// x is input in 2's complement
	
	// This part should include your own processing hardware
	// ... that takes x to produce y
	pulse_gen  	PULSE (wren, data_valid, sysclk);
	
	assign wrreq = wren;
	
	FSM			FSM_OUT(sysclk,full,fifo_state);
	fifo			FIFO_OUT(sysclk,x,fifo_state&wren,wrreq,full,q);	//simple echo
	
	assign y = x + {q[9], q[9:1]};	//simple echo
	
	//fifo			FIFO_OUT(sysclk,y,fifo_state&wren,wrreq,full,q);	//multi echoes
	
	//assign y = x - {q[9], q[9:1]};	//multi echoes
	
	//  Now clock y output with system clock
	always @(posedge sysclk)
		if (wren == 1'b1)
			data_out <=  y + DAC_OFFSET;
		
endmodule
	