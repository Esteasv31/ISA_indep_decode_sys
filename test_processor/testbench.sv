/* 
 * Basic test bench to test the top processor module
 * This one runs the processor and the test code and check for it to complete
 * it test that the last result of the program is correct and is hold on the data memory
 * 
 */
module testbench #(parameter WIDTH = 32,
						 parameter SIZE = 64)
						();

logic clk;
logic reset;
logic [WIDTH-1:0] WriteData, DataAdr, PC, Instr, ReadData;
logic MemWrite;

// instantiate device to be tested
top #(WIDTH, SIZE) dut(clk, reset, WriteData, DataAdr, PC, Instr, ReadData, MemWrite);

// initialize test
initial
	begin
		reset <= 1; # 25; reset <= 0;
	end
	
// generate clock to sequence tests
always
	begin
	clk <= 1; # 10; clk <= 0; #10;
end

// check that 7 gets written to address 0x64
// at end of program
always @(negedge clk)
	begin
		if(MemWrite) begin
			if(DataAdr === 100 & WriteData === 7) begin
				$display("Simulation succeeded");
				$stop;
			end 
			else if (DataAdr !== 96) begin
				$display("Simulation failed");
				$stop;
			end
		end
		$display("PC = %h, Instr = %h, ", PC, Instr);
	end

endmodule
