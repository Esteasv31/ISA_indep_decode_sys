module top #(parameter WIDTH = 32)
			   ();

adderTestBench #(WIDTH,"outputs/add_output.txt", "inputs/add_input.txt") adderTest ();

endmodule
