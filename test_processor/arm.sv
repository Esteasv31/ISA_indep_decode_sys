module ARM #(parameter WIDTH = 32,
				 parameter PCADD = 32'b100)
				(input logic clk, reset,
				output logic [WIDTH-1:0] pc,
				 input logic [WIDTH-1:0] instrF,
				output logic memWriteM,
				output logic [WIDTH-1:0] aluResultM, writeData,
				 input logic [WIDTH-1:0] readDataM);
				 
// Fetch Segment 

logic [WIDTH-1:0] resultW, pcPlus, pcData1, aluResultE, pcData2;
logic pcSrcW, branchETaken, stallF;

MUX2  #(WIDTH) pcSrcW_ (pcPlus, resultW, pcSrcW, pcData1);
MUX2  #(WIDTH) branchETaken_ (pcData1, aluResultE, branchETaken, pcData2);
FLOPR #(WIDTH) pcReg_ (clk, reset, stallF, pcData2, pc);
ADD   #(WIDTH) pcAdd_ (pc, PCADD, pcPlus);

//---------------------------------------------------------------------------

// Fetch - Decode Register 

logic stallD, flushD;
logic [WIDTH-1:0] instrD;
 
FLOPENCLR #(WIDTH) fetch_decode (clk, reset, flushD, stallD, instrF, instrD);

//---------------------------------------------------------------------------

// Decode Segment

logic [1:0] regSrcD, immSrcD, flagWriteD, aluControlD;
logic [3:0] RAD1, RAD2, WA3W;
logic regWriteW, pcSrcD, regWriteD, memWriteD, memToRegD, aluSrcD, branchD;
logic [WIDTH-1:0] RD1, RD2, extImmD;

MUX2 #(4) RAD1_ (instrD[19:16], 4'd15, regSrcD[0], RAD1);
MUX2 #(4) RAD2_ (instrD[3:0], instrD[15:12], regSrcD[1], RAD2);
REGFILE #(WIDTH) registerFile_ (~clk, regWriteW, RAD1, RAD2, WA3W, resultW, pcPlus, RD1, RD2);
EXTEND #(WIDTH) extend_ (instrD[23:0], immSrcD, extImmD);
DECODER controlUnit_ (instrD[27:26], instrD[25:20], instrD[15:12], 
							 flagWriteD, pcSrcD, regWriteD, memWriteD, memToRegD, aluSrcD, immSrcD, regSrcD, 
							 aluControlD, branchD);
							 
//---------------------------------------------------------------------------

// Decode - Exe Register

logic [1:0] flagWriteE, aluControlE;
logic pcSrcE, regWriteE, memWriteE, memToRegE, aluSrcE, branchE, flushE;
logic [3:0] flagsD, flagsE, condE, WA3E, RA1E, RA2E;
logic [WIDTH-1:0] RD1E, RD2E, extImmE;

FLOPCLR #(WIDTH) decode_exe (clk, reset, flushE, RD1, RD2, extImmD, instrD[15:12], pcSrcD, regWriteD,
									memToRegD, memWriteD, branchD, aluSrcD, flagWriteD, aluControlD, 
									flagsD, instrD[31:28],	flagsE, condE, flagWriteE, aluControlE, 
									pcSrcE, regWriteE, memWriteE, memToRegE, aluSrcE, branchE, WA3E, 
									RD1E, RD2E, extImmE, RAD1, RAD2, RA1E, RA2E);
								
//---------------------------------------------------------------------------

//Execution Segment
						
logic [WIDTH-1:0] srcAE, srcBE, srcXE;
logic [1:0] fordwareAE, fordwareBE;
logic [3:0] aluFlags;
logic pcSrcX, regWriteX, memWriteX, condEx;

assign srcAE = fordwareAE[1] ? (aluResultM) : (fordwareAE[0] ? resultW : RD1E);
assign srcXE = fordwareBE[1] ? (aluResultM) : (fordwareAE[0] ? resultW : RD2E);
MUX2 #(WIDTH) scrBE_ (srcXE, extImmE, aluSrcE, srcBE);
ALU #(WIDTH) alu_ (srcAE, srcBE, aluControlE, aluResultE, aluFlags);
CONDLOGIC CondUnit_ (clk, reset, condE, aluFlags, flagsE, flagWriteE, pcSrcE, 
							regWriteE, memWriteE, pcSrcX, regWriteX, memWriteX, condEx,
							flagsD);
assign branchETaken = condEx & branchE;		
	
//---------------------------------------------------------------------------

//Exe - Mem Register

logic pcSrcM, regWriteM, memToRegM;
logic [3:0] WA3M;

FLOPMEM #(WIDTH) exe_mem (clk, reset, aluResultE, srcXE, WA3E, pcSrcX, regWriteX,
							  memWriteX, memToRegE, pcSrcM, regWriteM, memWriteM, memToRegM,
							  WA3M, aluResultM, writeData);

//---------------------------------------------------------------------------

//MEM - WB Register

logic [WIDTH-1:0] readDataW, aluOutW;
logic memToRegW;

FLOPWB #(WIDTH) mem_wb (clk, reset, pcSrcM, regWriteM, memToRegM, WA3M, aluResultM, readDataM,
							   readDataW, aluOutW, WA3W, pcSrcW, regWriteW, memToRegW);
 
//---------------------------------------------------------------------------

//Write Back

MUX2 #(WIDTH) ResultW_ (aluOutW, readDataW, memToRegW, resultW);

//---------------------------------------------------------------------------

//Hazar Unit

logic match_1E_M, match_1E_W, match_2E_M, match_2E_W, match_12D_E, LDRstall, pcWrPendingF;

assign match_1E_M = (RA1E == WA3M);
assign match_1E_W = (RA1E == WA3W);
assign match_2E_M = (RA2E == WA3M);
assign match_2E_W = (RA2E == WA3W);
assign match_12D_E = (RAD1 == WA3E) | (RAD2 == WA3E);
assign pcWrPendingF = pcSrcD | pcSrcE | pcSrcM;

HAZARDU HazardUnit_ (regWriteW, regWriteM, memToRegE, match_1E_M, match_1E_W, match_2E_M, match_2E_W,
							fordwareAE, fordwareBE, match_12D_E, LDRstall);
							
assign stallD = LDRstall;
assign stallF = LDRstall | pcWrPendingF;
assign flushE = LDRstall | branchETaken;
assign flushD = pcWrPendingF | pcSrcW | branchETaken;

endmodule
















	