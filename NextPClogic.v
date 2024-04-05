module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input	Branch, ALUZero, Uncondbranch; 
   output reg [63:0] NextPC; 

   /* write your code here */

   wire and1; // (Branch AND ZeroFlag) OR UncondBranch this is mux switch
   wire or1;
   assign and1 = Branch & ALUZero;
   assign or1 = and1 | Uncondbranch; // essentially (Branch & ALUZero) | (UncondBranch)
   
   always @(*) begin
      if (or1 == 1) // branch to specific line
	NextPC = CurrentPC + (SignExtImm64 << 2);  // word offset (lsl2bits) -> byte offset
      else // default case
	NextPC = CurrentPC + 4;
   end // always block


endmodule
