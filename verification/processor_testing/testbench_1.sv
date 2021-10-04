/* 
 * Basic test bench to test the top processor module
 * This one runs the processor and the test code and check for it to complete
 * it test that the last result of the program is correct and is hold on the data memory
 * 
 */
module testbenchA #(parameter WIDTH = 32,
						 parameter SIZE = 112)
						();

logic clk;
logic reset;
logic [WIDTH-1:0] WriteData, DataAdr, PC, Instr, ReadData;
logic MemWrite;
integer f;
realtime time_s1 = 0.0;
realtime time_s2 = 0.0;

// instantiate device to be tested
top #(WIDTH, SIZE, "inputs/dot_and_cross_product.dat") dut (clk, reset, WriteData, DataAdr, PC, Instr, ReadData, MemWrite);

// initialize test
initial
	begin
		$timeformat(-9, 2, " ns", 10);
		f = $fopen("outputs/testbench1_output.txt","w");
		reset <= 1; # 25; reset <= 0;
		time_s1 = $realtime ;
		$display("Time 1: %t", time_s1);
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
				time_s2 = $realtime;
				$display("Time Diff      : %t", time_s2 - time_s1);
				$fclose(f);
				$display("Simulation succeeded");
				$stop;
			end 
			else if (DataAdr !== 96) begin
				time_s2 = $realtime;
				$display("Time Diff      : %t", time_s1 - time_s2);
				$fclose(f);
				$display("Simulation failed");
				$stop;
			end
		end
		$display("PC = %h, Instr = %h, ", PC, Instr);
		$fwrite(f,"%h\n", Instr);
	end

endmodule
