module ControlUnit (input logic clk, reset, PCcpu, branch, encode,
						  output logic branchMux, PCcompress, inputBuff, tableMux, outMux, PCintern, outBuff1, outBuff2);

logic instrCached;

// syncronize clk to write the instrCache and reset to 0 after second instr release to CPU							  
FLOPR #(1) instructionReg (clk, reset, 0, (~instrCached & encode), instrCached); 

assign branchMux = branch & ~PCcpu;//

assign PCcompress = (~instrCached & ~branch & encode) | (~instrCached & PCcpu & ~encode) | (PCcpu & branch & encode) | (instrCached & PCcpu & ~branch) | (instrCached & PCcpu & branch & ~encode);//

assign inputBuff = PCcpu;//

assign tableMux = (~instrCached & ~branch & encode) | (PCcpu & branch & encode) | (instrCached & PCcpu & ~branch & encode);//

assign outMux = instrCached & ((instrCached & ~branch) | PCcpu);//

assign PCintern = PCcpu;//

assign outBuff1 = 0;//

assign outBuff2 = 0;//

endmodule 