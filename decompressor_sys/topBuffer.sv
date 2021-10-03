/* 
 * Top module - holds the decompression (with In/Out Register) attached to the instruction memory
 * WIDTH = word length of the system
 * PCADD = off-set to add to the pc on each cycle
 * OPcode = opcode of the compressed instructions
 * encodeLength = length of the opcode used by the tokens
 * InitTokenFile = dat file holding the instructions to be save on the decompressor system
 * memFile = dat file holding the program instructions compressed
 * tokenSize = size of 'InitTokenFile' to set the size of the tokens table memory
 * memSize = size of 'memFile' to set the size of the instruction memory
 */
module topBuffer #(parameter WIDTH = 32,
					 parameter PCADD = 32'b100,
					 parameter OPcode = 4'b1111,
					 parameter encodeLength = 4,
					 parameter InitTokenFile = "tokenTable.dat",
					 parameter memFile = "memfile.dat",
					 parameter tokenSize = 102,
					 parameter memSize = 102)
			   (input logic clk, reset,
				 input logic [WIDTH-1:0] PCcpu,
				output logic [WIDTH-1:0] DecompressInstr);
				
logic wme;
logic [WIDTH-1:0] NextInstr, WriteData, PCcompress;

// Decompressor Module
DecompressorBuff #(WIDTH, PCADD, OPcode, encodeLength, InitTokenFile, tokenSize) 
	decompressorModule (clk, reset, wme, PCcpu, NextInstr, WriteData, PCcompress, DecompressInstr);
	
// instantiate instruction memories
imem #(WIDTH, memSize, memFile) imem (PCcompress, NextInstr);

endmodule
