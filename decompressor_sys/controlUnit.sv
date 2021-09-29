module ControlUnit (input logic clk, reset, PCcpu, branch, encode,
						  output logic branchMux, PCcompress, inputBuff, tableMux, outMux, PCintern, outBuff1, outBuff2);

logic instrCached;

// syncronize clk to write the instrCache and reset to 0 after second instr release to CPU							  
FLOPR #(1) instructionReg (clk, reset, ~encode, encode, instrCached); 

assign branchMux = branch & ~PCcpu;
assign PCcompress = (instrCached & ~PCcpu & ~branch) | PCcpu;
assign inputBuff = PCcompress;
assign tableMux = encode;
assign outMux = instrCached & ~PCcpu & ~branch;
assign PCintern = PCcpu;
assign outBuff1 = PCcpu;
assign outBuff2 = (instrCached & PCcpu) | (~PCcpu & ~encode) | (~instrCached & PCcpu & encode);

endmodule 