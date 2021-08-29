module top #(parameter WIDTH = 32,
				 parameter SIZE = 23)
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

//imem testbench
imemTestBench #(WIDTH, SIZE, "inputs/imem_data.txt", "outputs/imem_output.txt", "inputs/imem_input.txt") imemTest ();

//dmem testbench
dmemTestBench #(WIDTH, SIZE, "outputs/dmem_output.txt", "inputs/dmem_input.txt") imemTest ();

//dmem testbench
extendTestBench #(WIDTH, "outputs/extend_output.txt", "inputs/extend_input.txt") extendTest ();

//regfile testbench
regfileTestBench #(WIDTH, "outputs/regFile_output.txt", "inputs/regFile_input.txt") regfileTest ();

//flopr testbench
floprTestBench #(WIDTH, "outputs/flopr_output.txt", "inputs/flopr_input.txt") floprTest ();

endmodule
