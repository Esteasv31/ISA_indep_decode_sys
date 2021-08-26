module ALU #(parameter WIDTH = 32)
				(input logic [WIDTH-1:0] a, b,
				 input logic [1:0] aluControl,
				output logic [WIDTH-1:0] c,
				output logic [3:0] aluFlags);
				
logic [WIDTH-1:0] sum, n;
logic cOut;

assign n = aluControl[0] ? ~b : b;

ADD_CARRY #(WIDTH) adder_carry (a, n, aluControl[0], sum, cOut);

assign c = aluControl[0] ? (aluControl[1] ? (a | b) : (sum) ) : (aluControl[1] ? (a & b) : (sum) );

assign aluFlags[0] = (~(aluControl[0] ^ a[WIDTH-1] ^ b[WIDTH-1])) & (a[WIDTH-1] ^ sum[WIDTH-1]) & (~aluControl[1]);

assign aluFlags[1] = (~aluControl[1]) & (cOut);

assign aluFlags[2] = &(~c);

assign aluFlags[3] = c[WIDTH-1];

endmodule 