module FSM(

	input		clk,
	input		full,
	output 	reg FSM_enable
);
	
	// Define the state using one-hoting coding
	parameter	stateA = 1'b00;
	parameter	stateB = 1'b10;
	
	parameter	NSTATE = 2;

	reg	[NSATE-1:0]state;
	
	initial	state = 0;
	

	always @(posedge clk)
		begin
			case(state)
				stateA: if(full==1'b1)
							state <= 1'b1;
							
				stateB: ;//state <= 1'b0;
				default: ;
				endcase
			
		end
	
	always @(*)
		begin
			case(state)
				stateA:	FSM_enable = 0;
				stateB: FSM_enable = 1;
			endcase
		
		end
		
endmodule