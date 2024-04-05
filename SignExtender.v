module SignExtender(BusImm, Imm26, Ctrl); 
   output [63:0] BusImm; // 64 bit
   input [25:0] Imm26; // 26 bit
   // old Ctrl (without MOVZ): input [1:0] Ctrl; // 2 bit
   input [2:0] 	Ctrl; // three bits wide to include MOVZ instruction
   
  
   // temp TA told us to write the code without always block, as this method is much more straightforward. 
   assign BusImm =
		 (Ctrl == 3'b000) ? ({{38{Imm26[25]}}, Imm26[25:0]}):  // case B -> 26 + 38 = 64
                 (Ctrl == 3'b001) ? ({{45{Imm26[23]}}, Imm26[23:5]}):  // case CBZ -> 19 + 45 = 64
                 (Ctrl == 3'b010) ? ({{55{Imm26[20]}}, Imm26[20:12]}): // case D -> 9 + 55 = 64
                 (Ctrl == 3'b011) ? ({{52'b0}, Imm26[21:10]}):         // case I -> 12 + 52 = 64
	         (Ctrl == 3'b100) ? ({48'b0, Imm26[20:5]}):
		 (Ctrl == 3'b101) ? ({32'b0, Imm26[20:5], 16'b0}):
		 (Ctrl == 3'b110) ? ({16'b0, Imm26[20:5], 32'b0}):
		 (Ctrl == 3'b111) ? ({Imm26[20:5], 48'b0}): // case IM left shifted by x bits
                 0;
endmodule
