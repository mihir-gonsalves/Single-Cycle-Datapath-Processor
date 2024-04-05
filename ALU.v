`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111


module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    
    output  [63:0] BusW;
    input   [63:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  Zero;
    
    reg     [63:0] BusW;
    
    always @(*) begin
        case(ALUCtrl)
            `AND: begin // h'0
                BusW = BusA & BusB; 
	     end
	    `OR: begin // h'1
	        BusW = BusA | BusB;
	     end
	    `ADD: begin // h'3
	        BusW = BusA + BusB;
	     end
	    `SUB: begin // h'6
	        BusW = BusA - BusB;
	     end
	    `PassB: begin //h'7
	        BusW = BusB;
            end
        endcase
    end // always @ (ALUCtrl or BusA or BusB)

   
   assign Zero = (BusW == 0);  //0 or 1; a statement: (BusW == 0)
   // if BusW == 0, Zero = 1
   // else if BusW != =, Zero = 0
   
 
endmodule // THIS FILE IS COMPLETE
