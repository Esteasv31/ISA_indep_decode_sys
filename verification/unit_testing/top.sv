module top #(parameter WIDTH = 32)
			   ();

// simple adder testbench
adderTestBench #(WIDTH, "outputs/add_output.txt", "inputs/add_input.txt") adderTest ();

// adder with carry testbench
adderCarryTestBench #(WIDTH, "outputs/addCarry_output.txt", "inputs/addCarry_input.txt") adderCarryTest ();

//alu testbench
aluTestBench #(WIDTH, "outputs/alu_output.txt", "inputs/alu_input.txt") aluTest ();

endmodule
