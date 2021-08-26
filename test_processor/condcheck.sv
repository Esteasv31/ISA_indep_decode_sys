module CONDCHECK (input logic [3:0] Cond,
						input logic [3:0] Flags,
					  output logic CondEx);
						
logic neg, zero, carry, overflow;

assign {neg, zero, carry, overflow} = Flags;

always_comb
	case(Cond)
		4'b0000: CondEx = zero; // EQ
		4'b0001: CondEx = ~zero; // NE
		4'b0010: CondEx = carry; // CS
		4'b0011: CondEx = ~carry; // CC
		4'b0100: CondEx = neg; // MI
		4'b0101: CondEx = ~neg; // PL
		4'b0110: CondEx = overflow; // VS
		4'b0111: CondEx = ~overflow; // VC
		4'b1000: CondEx = carry & ~zero; // HI
		4'b1001: CondEx = ~carry | zero; // LS
		4'b1010: CondEx = ~(neg ^ overflow); // GE
		4'b1011: CondEx = neg ^ overflow; // LT
		4'b1100: CondEx = ~zero & ~(neg ^ overflow); // GT
		4'b1101: CondEx = zero | (neg ^ overflow); // LE
		4'b1110: CondEx = 1'b1; // Always
		default: CondEx = 1'bx; // undefined
	endcase
	
endmodule
