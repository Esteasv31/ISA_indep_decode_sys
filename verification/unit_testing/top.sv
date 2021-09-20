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
condlogicTestBench #(WIDTH, "outputs/condLogic_output.txt", "inputs/condLogic_input.txt") condLogicTest ();

//mux testbench
muxTestBench #(WIDTH, "outputs/mux_output.txt", "inputs/mux_input.txt") muxTest ();

//imem testbench
imemTestBench #(WIDTH, SIZE, "inputs/imem_data.txt", "outputs/imem_output.txt", "inputs/imem_input.txt") imemTest ();

//dmem testbench
dmemTestBench #(WIDTH, SIZE, "outputs/dmem_output.txt", "inputs/dmem_input.txt") dmemTest ();

//dmem testbench
extendTestBench #(WIDTH, "outputs/extend_output.txt", "inputs/extend_input.txt") extendTest ();

//regfile testbench
regfileTestBench #(WIDTH, "outputs/regFile_output.txt", "inputs/regFile_input.txt") regfileTest ();

//flopr testbench
floprTestBench #(WIDTH, "outputs/flopr_output.txt", "inputs/flopr_input.txt") floprTest ();

//flopmem testbench
flopmemTestBench #(WIDTH, "outputs/flopmem_output.txt", "inputs/flopmem_input.txt") flopmemTest ();

//flopenr testbench
flopenrTestBench #(WIDTH, "outputs/flopenr_output.txt", "inputs/flopenr_input.txt") flopenrTest ();

//flopclr testbench
flopclrTestBench #(WIDTH, "outputs/flopclr_output.txt", "inputs/flopclr_input.txt") flopclrTest ();

//flopwb testbench
flopwbTestBench #(WIDTH, "outputs/flopwb_output.txt", "inputs/flopwb_input.txt") flopwbTest ();

//hazardU testbench
hazardUTestBench #(WIDTH, "outputs/hazardU_output.txt", "inputs/hazardU_input.txt") hazardUTest ();

//decoder testbench
decoderTestBench #(WIDTH, "outputs/decoder_output.txt", "inputs/imem_data.txt") decoderTest ();

//TokenTable testbench

//AND testbench
andTestBench #(WIDTH, "outputs/and_output.txt", "inputs/and_input.txt") andTest ();

//Decompressor Control Unit testbench

//Comparator testbench
comparatorTestBench #(WIDTH, "outputs/comparator_output.txt", "inputs/comparator_input.txt") comparatorTest ();

//GratherLess testbench

//Buffers testbench

//Latches testbench

endmodule
