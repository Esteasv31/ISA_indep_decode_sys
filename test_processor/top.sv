module top #(parameter WIDTH = 32,
				 parameter SIZE = 102)
			   (input logic clk, reset,
				output logic [WIDTH-1:0] WriteData, DataAdrA, PC, Instr, ReadData,
				output logic MemWrite);

// instantiate processor
ARM #(WIDTH, 32'b100) armPipeLine (clk, reset, PC, Instr, MemWrite, DataAdrA, WriteData, ReadData);

// instantiate instruction memories
imem #(WIDTH, SIZE, "memfile.dat") imem (PC, Instr);

// instantiate data memories
dmem #(WIDTH, SIZE) dmem (clk, MemWrite, DataAdrA, WriteData, ReadData);

endmodule
