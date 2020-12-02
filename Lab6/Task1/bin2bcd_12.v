// Design Name : bin2bcd_12
// File Name : bin2bcd_16.v
// Function : convert 16-bit binary number x to five BCD digits
// Author:  Peter Cheung
// Version: 1.0 (14 Nov 2020)
//---------------------------------------------------
//ALGORITHM: (See explanation on course webpage)
//   Shift binary number x left by one bit into temporary register 'result'
//   If bottom 4 bits of result  >= 5
//		add 3 (only once)
//   Continue shifting x into result until all bit in x have been processed


module bin2bcd_12(x, BCD0, BCD1, BCD2, BCD3);
	input[11:0] x;			// value ot be converted
	output reg[3:0] BCD0, BCD1, BCD2, BCD3;  // BCD digits
	
	 // Concatenation of input and output
   reg [27:0] result;  // no of bits = no_of_bit of x + 4* no of digits
   integer i;
   
   always @(*)
   begin
      result[27:0] = 0;
      result[11:0] = x;

      for (i=0; i<12; i=i+1) begin
				
         // Check if ten digita >= 5
         if (result[15:12] >= 5)
            result[15:12] = result[15:12] + 4'd3;
            
			// CHeck if hundred digit >= 5
         if (result[19:16] >= 5)
            result[19:16] = result[19:16] + 4'd3;
				
			// check if thousand digit > 5
         if (result[23:20] >= 5)
            result[23:20] = result[23:20] + 4'd3;

			// Shift everything left
         result = result << 1;
      end
      
      // Decode output from result
      BCD0 = result[15:12];
		BCD1 = result[19:16];		
		BCD2 = result[23:20];
		BCD3 = result[27:24];
   end
	
endmodule