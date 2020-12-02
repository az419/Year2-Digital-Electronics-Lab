module FSM(

	input		clk,
	input		full,
	output 	reg FSM_enable
);

	reg		state;
	
	initial	state = 0;
	

	always @(posedge clk)
		begin
			case(state)
				1'b0: if(full==1'b1)
							state <= 1'b1;
							
				1'b1:	; //state <= 1'b0;
				endcase
			
		end
	
	always @(*)
		begin
			case(state)
				1'b0:	FSM_enable <= 0;
				1'b1: FSM_enable <= 1;
			endcase
		
		end
		
endmodule