module CONDLOGIC (input logic clk, reset,
						input logic [3:0] Cond, ALUFlags, prevFlags,
						input logic [1:0] FlagW,
						input logic PCS, RegW, MemW,
						output logic PCSrc, RegWrite, MemWrite, CondEx,
						output logic [3:0] FlagsX);
						
logic [1:0] FlagWrite;
logic [3:0] Flags;

FLOPENR #(2) flagreg1 (clk, reset, FlagWrite[1], ALUFlags[3:2], Flags[3:2]);

FLOPENR #(2) flagreg0 (clk, reset, FlagWrite[0], ALUFlags[1:0], Flags[1:0]);

// write controls are conditional
CONDCHECK cc (Cond,  Flags, CondEx);

assign FlagWrite = FlagW & {2{CondEx}};
assign RegWrite = RegW & CondEx;
assign MemWrite = MemW & CondEx;
assign PCSrc = PCS & CondEx;
assign FlagsX = ALUFlags;

endmodule

