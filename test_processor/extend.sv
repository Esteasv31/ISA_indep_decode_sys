module EXTEND #(parameter WIDTH = 32)
					(input logic [WIDTH-9:0] instr,
					 input logic [1:0] immSrc,
					output logic [WIDTH-1:0] extImm);
		
// Fix always_comb logic to work with a dinamyc WIDTH and return the propper extImm length 		

always_comb
	case (immSrc)
		// 8-bit unsigned immediate
		2'b00: extImm = {24'b0, instr[WIDTH-25:0]};
		// 12-bit unsigned immediate
		2'b01: extImm = {20'b0, instr[WIDTH-21:0]};
		// 24-bit two's complement shifted branch
		2'b10: extImm = {{6{instr[WIDTH-9]}}, instr[WIDTH-9:0], 2'b00};
		default: extImm = 32'bx; // undefined
	endcase
	
endmodule
