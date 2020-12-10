module DELAY(clk,trigger,N,time_out,result);

	input		clk,trigger;
	input		[6:0]N;
	output reg time_out;
	output reg [13:0]result;
	
	reg	[13:0]count;
	//reg	time_out;
	//reg	[13:0]result;

	
	always @(posedge clk)
		begin
			if(trigger==1'b0)
			begin
				count <= {N,7'b0};
				result <= {N,7'b0};
				//time_out <= 1'b0;
			end
			if(trigger==1'b1)
			begin
				if(count==1'b0)
					begin
					time_out <= 1'b1;
					count <= 14'b1;	//cannot be assigned to a zero value!!! 
					end
				else
					begin
					time_out <= 1'b0;
					count <= count-1'b1;
					end
			end
		end
		
			
endmodule
