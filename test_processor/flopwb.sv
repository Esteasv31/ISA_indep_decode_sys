/* 
 * custom FLIP-FLOP 
 * this flip-flop goes between the memory and write-back stage
 * 
 */
module FLOPWB #(parameter WIDTH = 32)
					(input logic clk, reset,
					input logic prsrc, regwrite, memtoreg,
					input logic [3:0] wa3m,
					input logic [WIDTH-1:0] Aludata, readData,
					output logic [WIDTH-1:0] ReadDataW, ALUOutW,
					output logic [3:0] WA3W,
					output logic PCSrcW, RegWriteW, MemtoRegW);
					
always_ff @(posedge clk, posedge reset)
	if (reset) begin
		ReadDataW <= 0;
		ALUOutW <= 0;
		WA3W <= 0;
		PCSrcW <= 0;
		RegWriteW <= 0;
		MemtoRegW <= 0;
	end
	else begin
		ReadDataW <= readData;
		ALUOutW <= Aludata;
		WA3W <= wa3m;
		PCSrcW <= prsrc;
		RegWriteW <= regwrite;
		MemtoRegW <= memtoreg;
	end
	
endmodule
