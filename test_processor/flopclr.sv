/* 
 * custom FLIP-FLOP 
 * holds a clear (clr) signal to clear the register values
 * this flip-flop goes between the decode and the execution stage
 * 
 */
module FLOPCLR #(parameter WIDTH = 32)
					 (input logic clk, reset, clr,
					  input logic [WIDTH-1:0] rd1, rd2, extImm,
					  input logic [3:0] wa3d,
					  input logic pcsrcD, regwrited, memtoregd, memwrited, branchd, alusrcd,
					  input logic [1:0] flagwrited, alucontrold,
					  input logic [3:0] flagsd, condd,
					 output logic [3:0] FlagsE, CondE,
					 output logic [1:0] FlagWriteE, ALUControlE,
					 output logic PCSrcE, RegWriteE, MemWriteE, MemtoRegE, ALUSrcE, BranchE,
					 output logic [3:0] WA3E,
					 output logic [WIDTH-1:0] RD1, RD2, EXTIMM,
					  input logic [3:0] ra1d, ra2d,
					 output logic [3:0] RA1E, RA2E);
					
always_ff @(posedge clk, posedge clr, posedge reset)
	if (reset) begin
		 FlagsE <= 0;
		 CondE <= 0;
		 FlagWriteE <= 0;
		 ALUControlE <= 0;
		 PCSrcE <= 0;
		 RegWriteE <= 0;
		 MemWriteE <= 0;
		 MemtoRegE <= 0;
		 ALUSrcE <= 0;
		 BranchE <= 0;
		 WA3E <= 0;
		 RD1 <= 0;
		 RD2 <= 0;
		 EXTIMM <= 0;
		 RA1E <= 0;
		 RA2E <= 0;
	end
	else if (clr) begin
		 FlagsE <= 0;
		 CondE <= 0;
		 FlagWriteE <= 0;
		 ALUControlE <= 0;
		 PCSrcE <= 0;
		 RegWriteE <= 0;
		 MemWriteE <= 0;
		 MemtoRegE <= 0;
		 ALUSrcE <= 0;
		 BranchE <= 0;
		 WA3E <= 0;
		 RD1 <= 0;
		 RD2 <= 0;
		 EXTIMM <= 0;
		 RA1E <= 0;
		 RA2E <= 0;
	end
	else begin
		 FlagsE <= flagsd;
		 CondE <= condd;
		 FlagWriteE <= flagwrited;
		 ALUControlE <= alucontrold;
		 PCSrcE <= pcsrcD;
		 RegWriteE <= regwrited;
		 MemWriteE <= memwrited;
		 MemtoRegE <= memtoregd;
		 ALUSrcE <= alusrcd;
		 BranchE <= branchd;
		 WA3E <= wa3d;
		 RD1 <= rd1;
		 RD2 <= rd2;
		 EXTIMM <= extImm;
		 RA1E <= ra1d;
		 RA2E <= ra2d;
	end
	
endmodule
