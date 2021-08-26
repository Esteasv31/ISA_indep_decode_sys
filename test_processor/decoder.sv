module DECODER (input logic [1:0] op,
					 input logic [5:0] funct,
					 input logic [3:0] rd,
					output logic [1:0] flagW,
					output logic pcs, regW, memW, memToReg, aluSrc,
					output logic [1:0] immSrc, regSrc, aluControl,
					output logic branch);
					
logic [9:0] controls;
logic aluOp;

// Main Decoder
always_comb
	casex(op)
		// Data-processing immediate
		2'b00: if (funct[5]) controls = 10'bx000001001;
		// Data-processing register
		else controls = 10'b00xx001001;
		// LDR
		2'b01: if (funct[0]) controls = 10'bx001111000;
		// STR 
		else controls = 10'b10011x0100;
		// B
		2'b10: controls = 10'bx110100010;
		// Unimplemented
		default: controls = 10'bx;
	endcase
	
assign {regSrc, immSrc, aluSrc, memToReg, regW, memW, branch, aluOp} = controls;

// ALU Decoder
always_comb
	if (aluOp) begin // which DP Instr?
		case(funct[4:1])
			4'b0100: aluControl = 2'b00; // ADD
			4'b0010: aluControl = 2'b01; // SUB
			4'b0000: aluControl = 2'b10; // AND
			4'b1100: aluControl = 2'b11; // ORR
			default: aluControl = 2'bx; // unimplemented
		endcase
		// update flags if S bit is set (C & V only for arith)
		flagW[1] = funct[0];
		flagW[0] = funct[0] & (aluControl == 2'b00 | aluControl == 2'b01);
		
	end 
	else begin
		aluControl = 2'b00; // add for non-DP instructions
		flagW = 2'b00; // don't update Flags
	end
	
// PC Logic
assign pcs = ((rd == 4'b1111) & regW) | branch;

endmodule
