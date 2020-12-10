module FSM(clk,tick,trigger,time_out,reset,en_lfsr,start_delay,LEDR);

	input clk,tick,trigger,time_out,reset;
	output en_lfsr,start_delay;
	output [9:0] LEDR;
	
	reg [9:0] LEDR;
	reg [3:0] state;
	reg en_lfsr,start_delay;

	
	parameter IDLE = 4'b0000;
	parameter LED9 = 4'b0001;
	parameter LED8 = 4'b0010;
	parameter LED7 = 4'b0011;
	parameter LED6 = 4'b0100;
	parameter LED5 = 4'b0101;
	parameter LED4 = 4'b0110;
	parameter LED3 = 4'b0111;
	parameter LED2 = 4'b1000;
	parameter LED1 = 4'b1001;
	parameter LED0 = 4'b1010;
	parameter HOLD = 4'b1011;
	parameter SHUT = 4'b1100;
	
	initial state = IDLE;
	initial en_lfsr = 1'b0;
	initial start_delay = 1'b0;
	initial LEDR [9:0] = 10'b0;
	
	
	always @ (posedge clk)
		case(state)
			IDLE: if(trigger == 1'b1) state <= LED9;
			LED9: if(tick==1'b1)	state <= LED8;
			LED8: if(tick==1'b1)	state <= LED7;
			LED7: if(tick==1'b1)	state <= LED6;
			LED6: if(tick==1'b1)	state <= LED5;
			LED5: if(tick==1'b1)	state <= LED4;
			LED4: if(tick==1'b1)	state <= LED3;
			LED3: if(tick==1'b1)	state <= LED2;
			LED2: if(tick==1'b1)	state <= LED1;
			LED1: if(tick==1'b1)	state <= LED0;
			LED0: if(tick==1'b1) state <= HOLD;
			HOLD: if(time_out == 1'b1) state <=SHUT;	//SHUT
			SHUT: if(reset==1'b1) state<= IDLE;	
			default:;
		endcase
		
	always @ (*)
		case (state)
		IDLE : begin LEDR[9:0] = 10'b0; start_delay <= 1'b0; en_lfsr = 1'b1; end
		LED9 : begin LEDR [9:0] = 10'b1000000000; en_lfsr = 1'b1; end
		LED8 : LEDR [9:0] = 10'b1100000000;
		LED7 : LEDR [9:0] = 10'b1110000000;
		LED6 : LEDR [9:0] = 10'b1111000000;
		LED5 : LEDR [9:0] = 10'b1111100000;
		LED4 : LEDR [9:0] = 10'b1111110000;
		LED3 : LEDR [9:0] = 10'b1111111000;
		LED2 : LEDR [9:0] = 10'b1111111100;
		LED1 : LEDR [9:0] = 10'b1111111110;
		LED0 : LEDR [9:0] = 10'b1111111111;
		HOLD : begin start_delay = 1'b1; LEDR [9:0] = 10'b1111111111; end
		SHUT : begin start_delay = 1'b0; LEDR [9:0] = 10'b0;  end
		
		
		endcase
		
	endmodule
		
			
