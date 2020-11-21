// Design Name : bin2bcd_7
// File Name : bin2bcd_7.v
// Function : convert 7-bit binary number x to two BCD digits
// Author:  Alyson Zhang
// Version: 1.0 (20 Nov 2020)
//---------------------------------------------------
//ALGORITHM: (See explanation on course webpage)
//   Shift binary number x left by one bit into temporary register 'result'
//   If bottom 4 bits of result  >= 5
//		add 3 (only once)
//   Continue shifting x into result until all bit in x have been processed


module bin2bcd_7(x, BCD0, BCD1);
	input[6:0] x;			// value ot be converted
	output reg[3:0] BCD0, BCD1;  // BCD digits
	
	 // Concatenation of input and output
   reg [14:0] result;  // no of bits = no_of_bit of x + 4* no of digits
   integer i;
   
   always @(*)
   begin
      result[14:0] = 0;
      result[6:0] = x;

      for (i=0; i<7; i=i+1) 
		begin
			// Check if unit digit >= 5
         if (result[11:8] >= 5)
            result[11:8] = result[11:8] + 4'd3;
				
         // Check if ten digita >= 5
         if (result[14:12] >= 5)
            result[14:12] = result[14:12] + 4'd3;

			// Shift everything left
         result = result << 1;
      end
      
      // Decode output from result
      BCD0 = result[11:8];
		BCD1 = {1'b0,result[14:12]};		
   end
	
endmodule
	