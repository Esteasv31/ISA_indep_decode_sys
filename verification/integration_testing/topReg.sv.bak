module topBuffer #(parameter WIDTH = 32,
					 parameter PCADD = 32'b100,
					 parameter OPcode = 4'b1111,
					 parameter encodeLength = 4,
					 parameter InitTokenFile = "tokenTable.dat",
					 parameter memFile = "memfile.dat",
					 parameter tokenSize = 102,
					 parameter memSize = 102)
			   (input logic clk, reset);
				
logic wme, MemWrite;
logic [WIDTH-1:0] NextInstr, WriteData, PCcompress, DataAdrA, WriteDataMem, ReadData;

// instantiate processor
ARM #(WIDTH, 32'b100) armPipeLine (clk, reset, PCcpu, DecompressInstr, MemWrite, DataAdrA, WriteDataMem, ReadData);

// Decompressor Module
DecompressorBuff #(WIDTH, PCADD, OPcode, encodeLength, InitTokenFile, tokenSize) 
	decompressorModule (clk, reset, wme, PCcpu, NextInstr, WriteData, PCcompress, DecompressInstr);
	
// instantiate instruction memories
imem #(WIDTH, memSize, memFile) imem (PCcompress, NextInstr);

// instantiate data memories
dmem #(WIDTH, memSize) dmem (clk, MemWrite, DataAdrA, WriteDataMem, ReadData);

endmodule



