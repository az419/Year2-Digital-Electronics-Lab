module clktick (
	clkin,		// clock input to the design
	enable,		// enable clk divider
	//N,				// clock division factor is N+1
	tick			// End of port list
	
);

	parameter	N_BIT = 16;
	parameter	N = 50000;
	
//---------------- Input Ports-----------------------
	input clkin;
	input enable;
	//input [N_BIT-1:0] N;
	
//---------------- Output Ports----------------------
	output tick;
	
//---------------- Output Ports Data Type ----------------------
// Output port can be a storage element (reg) or a wire
	reg [N_BIT-1:0] count;
	reg tick;
	
	initial tick = 1'b0;
	initial count = 0;
	
//---------------- Main body of this module ----------------------

	always @ (posedge clkin)
		if (enable == 1)
			if(count == 0)
				begin
				tick <= 1'b1;
				count <= N;
				end
			else
				begin
				tick <= 1'b0;
				count <= count - 1'b1;
				end

endmodule
