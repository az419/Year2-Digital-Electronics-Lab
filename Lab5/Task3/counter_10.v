`timescale 1ns / 100ps	// unit time is 1ns, resolution is 100ps

//--------------------------------------------------------------
// Design Name: Counter_10
// Function: a 10-bit synchronous counter with synchronous clock
//--------------------------------------------------------------

module counter_10 (
	clock,		// clock input
	enable,		// high enable counter
	count			// count value
);

// ------ Declare ports ------

	parameter BIT_SZ = 10;
	input clock;
	input enable;
	output [BIT_SZ-1:0] count;
	
// count needs to be declared as reg

	reg [BIT_SZ-1:0] count;
	
// ---- always initialise storage elements such as D-FF

	initial count = 0;

// ---- Main body of the module ------

	always @ (posedge clock)
		if (enable == 1'b1)
			count <= count + 1'b1;
			
endmodule