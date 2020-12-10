module Lab7Challenge4_top(MAX10_CLK1_50,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4);	

	input	 MAX10_CLK1_50;
	input  [1:0] KEY;
	output [9:0] LEDR;
	output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4;


	wire	tick_ms, tick_halfs;
	wire	EN_LFSR,	DELAY,TIME_OUT,reset;//,EN_REACT;
	wire 	enable_FSM;
	wire	[9:0] 	LEDR;
	wire	[6:0]		PRBS;
	wire	[3:0]		BCD0,BCD1,BCD2,BCD3,BCD4;
	wire	[13:0]	Delay_result;
	//wire  react_trigger;
	//wire	[15:0]	REACTION_TIME;
	
	assign enable_FSM = !KEY[1];
	assign reset = !KEY[0]&!KEY[1];
	//assign react_trigger = !KEY[0];
		
	clktick_1ms			msClk(MAX10_CLK1_50,1'b1,tick_ms);
	clktick_halfsec	half_secClk(MAX10_CLK1_50,tick_ms,tick_halfs);
	
	FSM			fsm(tick_ms,tick_halfs,enable_FSM,TIME_OUT,reset,EN_LFSR,DELAY,LEDR);
	LFSR			Random(PRBS,tick_ms,EN_LFSR);
	DELAY			Delay(tick_ms,DELAY,PRBS,TIME_OUT,Delay_result); //DELAY
	//REACTION		React(tick_ms,react_trigger,TIME_OUT,REACTION_TIME);
	
	bin2bcd_16		Converter(Delay_result,BCD0,BCD1,BCD2,BCD3,BCD4);
	hex_to_7seg		SEG0(HEX0, BCD0);
	hex_to_7seg		SEG1(HEX1, BCD1);
	hex_to_7seg		SEG2(HEX2, BCD2);
	hex_to_7seg		SEG3(HEX3, BCD3);
	hex_to_7seg		SEG4(HEX4, BCD4);	

	endmodule
	