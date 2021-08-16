module top #(parameter WIDTH = 32)
			   (input logic clk, reset,
				output logic [WIDTH-1:0] WriteData, DataAdrA, PC, Instr,
				output logic MemWrite);
				
logic [WIDTH-1:0] ReadDataMem, ReadDataIO, ReadData, DataAdrB, ReadDataReg;
logic dir_slt;

// instantiate processor
ARM armPipeLine (clk, reset, PC, Instr, MemWrite, DataAdrA, WriteData, ReadData);

// instantiate instruction memories
imem imem(PC, Instr);

// instantiate data memories
dmem dmem(clk, MemWrite, DataAdrA, WriteData, ReadData);

endmodule
