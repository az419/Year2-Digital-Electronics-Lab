module LFSR (prbs, clk, enable);

	output reg [7:1] prbs;
	input	clk;
	input	enable;

	
	initial prbs = 7'b1;
	
	always @ (posedge clk)
		if(enable==1'b1)
			prbs <= {prbs[6:1], prbs[1] ^ prbs[7]};


endmodule