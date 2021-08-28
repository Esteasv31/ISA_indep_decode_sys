module top #(parameter WIDTH = 32)
			   ();

// simple adder testbench
adderTestBench #(WIDTH, "outputs/add_output.txt", "inputs/add_input.txt") adderTest ();

// adder with carry testbench
adderCarryTestBench #(WIDTH, "outputs/addCarry_output.txt", "inputs/addCarry_input.txt") adderCarryTest ();

//alu testbench
aluTestBench #(WIDTH, "outputs/alu_output.txt", "inputs/alu_input.txt") aluTest ();

//conditional logic testbench
condcheckTestBench #(WIDTH, "outputs/condCheck_output.txt", "inputs/condCheck_input.txt") condCheckTest ();

//condlogicTestBench #(WIDTH, "outputs/condLogic_output.txt", "inputs/condLogic_input.txt") condLogicTest ();

//mux testbench
muxTestBench #(WIDTH, "outputs/mux_output.txt", "inputs/mux_input.txt") muxTest ();


endmodule
