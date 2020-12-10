module REACTION(clk,trigger,enable,reaction_time);

	input		clk;
	input		trigger,enable; // trigger: !KEY[0] enable: from FSM in SHUT
	output reg [15:0] reaction_time;
	
	reg	[15:0]	count;
	
	initial	count = 16'b0;
	
	always @ (posedge clk)
		begin
			if(enable==1'b1)
			begin
				count <= count + 1'b1;
			end
				if(trigger==1'b1)
				begin
					reaction_time <= count;
					count <= 16'b0;
				end
		end
		
endmodule
	
	
	
	