module DecompressorLatch #(parameter WIDTH = 32,
								   parameter PCADD = 32'b100,
								   parameter OPcode = 4'b1111,
								   parameter encodeLength = 4,
								   parameter InitFile = "tokenTable.dat",
								   parameter SIZE = 102)
								  (input logic clk, reset, wme,
								   input logic [WIDTH-1:0] PCcpu, NextInstr, WriteData,
								  output logic [WIDTH-1:0] PCcompress, DecompressInstr);
							
// Wires							
logic PCcpu1, branch, encode, branchMux, PCcompress1, inputBuff, tableMux, outMux;
logic PCintern, outBuff1, outBuff2;
logic [WIDTH-1:0] PC, pcPlus, instrToDecode, TableDir2, data1, data2, outInstr1, outData2, outData1, internalPC, internalPCPlus, notInstrToDecode, notDecompressInstr;

// Control Unit
ControlUnit ControlU (clk, reset, PCcpu1, branch, encode, branchMux, PCcompress1, inputBuff, 
								tableMux, outMux, PCintern, outBuff1, outBuff2);

// Input Management

	// stage #1
	MUX2  #(WIDTH) branchTaken (PC, PCcpu, branchMux, PCcompress);
	FLOPR #(WIDTH) pcReg (clk, reset, ~PCcompress1, pcPlus, PC);
	ADD   #(WIDTH) pcAdd (PCcompress, PCADD, pcPlus);

	// stage #2
	ANDModule   #(encodeLength) pcAnd (instrToDecode[WIDTH-1:WIDTH-encodeLength], OPcode, encode);

// Table Management
	MUX2  #(WIDTH) tableMux_ (instrToDecode, data1, tableMux, outInstr1);	

// Output Managament
	// stage 1
	COMPARATOR #(WIDTH) comparator (PCcpu, internalPC, PCcpu1);
	FLOPR #(WIDTH, 32'hFFFFFFFC) internalPCReg (clk, reset, PCcompress1, PCcpu, internalPC);
	ADD   #(WIDTH) internalPCAdd (internalPC, PCADD, internalPCPlus);
	GratherLess #(WIDTH) branchCheck (internalPCPlus, PCcpu, branch);
	
	// stage 2
	MUX2  #(WIDTH) outMux_ (outInstr1, outData2, outMux, outData1);	
	
// Input Buffer
	SRlatch #(WIDTH) inputLatch (NextInstr, {WIDTH{inputBuff}}, instrToDecode, notInstrToDecode);
	// Dlatch #(WIDTH) inputLatch (inputBuff, NextInstr, instrToDecode, notInstrToDecode);

// Conversion Table
	ADD   #(WIDTH) dirAdd (instrToDecode, PCADD, TableDir2);
	tokenTable #(WIDTH, SIZE, InitFile) conversionTable ({4'b0, instrToDecode[WIDTH-encodeLength-1:0]}, {4'b0, TableDir2[WIDTH-encodeLength-1:0]}, WriteData, clk, wme, data1, data2);

// Output Buffer
	FLOPR #(WIDTH) outputReg2 (clk, reset, outBuff2, data2, outData2);
	SRlatch #(WIDTH) outpuLatch (outData1, {WIDTH{outBuff1}}, DecompressInstr, notDecompressInstr);
	// Dlatch #(WIDTH) outpuLatch (outBuff1, outData1, DecompressInstr, notDecompressInstr);

endmodule
