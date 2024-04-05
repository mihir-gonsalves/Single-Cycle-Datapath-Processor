module RegisterFile(BusA, BusB, BusW, RW, RA, RB, RegWr, Clk);
    output [63:0] BusA; // 64 bits
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RW, RA, RB; // 5 bits
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0]; // 32x64 register file
     
    assign #2 BusA = registers[RA]; // BusA gets the value of RA
    assign #2 BusB = registers[RB]; // BusB gets the value of RB

   initial
     registers[31] <= 0; // this is the Zero register, we don't want Reg[31] to equal anything but 0.

   
    always @ (negedge Clk) begin
        if(RegWr) // if RegWR == 1 (is high)
	  if (RW != 5'd31) // we want to update all registers EXCEPT the Zero Register
            registers[RW] <= #3 BusW;
       
    end
   
endmodule
