`timescale 1ns / 100ps	// unit time is 1ns, resolution is 100ps

//--------------------------------------------------------------
// Design Name: Counter_4
// Function: a 4-bit synchronous counter with synchronous clock
//--------------------------------------------------------------

module counter_4 (
	clock,		// clock input
	enable,		// high enable counter
	reset,		// high reset counter to 0
	count			// count value
);

// ------ Declare ports ------

	parameter BIT_SZ = 4;
	input clock;
	input enable;
	input reset;
	output [BIT_SZ-1:0] count;
	
// count needs to be declared as reg

	reg [BIT_SZ-1:0] count;
	
// ---- always initialise storage elements such as D-FF

	initial count = 0;

// ---- Main body of the module ------

	always @ (posedge clock)
		if (reset==1'b1)
			count <= 0;
		else if (enable == 1'b1)
			count <= count + 1'b1;
			
endmodule