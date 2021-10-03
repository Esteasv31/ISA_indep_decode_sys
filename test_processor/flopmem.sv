/* 
 * custom FLIP-FLOP 
 * this flip-flop goes between the execution and memory stage
 * 
 */
module FLOPMEM #(parameter WIDTH = 32)
					 (input logic clk, reset,
					  input logic [WIDTH-1:0] aluResult, Wdata, 
					  input logic [3:0] wa3e,
					  input logic pcsrc, regW, memW, memtoreg,
					 output logic PCSrcM, RegWriteM, MemWriteM, MemtoRegM,
					 output logic [3:0] WA3M,
					 output logic [WIDTH-1:0] ALUResultM, WriteDataM);
					
always_ff @(posedge clk, posedge reset)
	if (reset) begin
		PCSrcM <= 0;
		RegWriteM <= 0;
		MemWriteM <= 0;
		MemtoRegM <= 0;
		WA3M <= 0;
		ALUResultM <= 0;
		WriteDataM <= 0;
	end
	else begin
		PCSrcM <= pcsrc;
		RegWriteM <= regW;
		MemWriteM <= memW;
		MemtoRegM <= memtoreg;
		WA3M <= wa3e;
		ALUResultM <= aluResult;
		WriteDataM <= Wdata;
	end
	
endmodule
