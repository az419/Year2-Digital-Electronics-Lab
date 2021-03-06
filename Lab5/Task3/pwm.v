//------------------------------
// Module name: pwm
// Function: 	converter data_in to a 10-bit PWM signal
//						... range of data_in - 0 to max
// Creator:  Peter Cheung
// Version:  1.0
// Date:     20 Nov 2020
//------------------------------
module pwm (clk, data_in, load, pwm_out, max);

	input				clk;			// system clock
	input [9:0] 	data_in;		// input data for conversion (limited to 10-bit)
	input 			load;			// high pulse to load new data
	input [9:0]		max;			// maximum value of data_in
	output			pwm_out;		// PWM output

	reg [9:0]		d;				// internal register
	reg [9:0]		count;		// internal 10-bit counter
	reg				pwm_out;
	
	// load input data into a register
	always @ (posedge clk)
		if (load == 1'b1) d <= data_in;
	
	initial count = 10'b0;	
	
	//ramp generator
	always @ (posedge clk) begin
		if (count == max)  count <= 10'b0;
		else
			count <= count + 1'b1;
		// digital comparator
		if (count >= d)
			pwm_out <= 1'b0;
		else	
			pwm_out <= 1'b1;
		end

endmodule