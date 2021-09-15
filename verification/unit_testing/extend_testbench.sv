module extendTestBench #(parameter WIDTH = 32,
								 parameter outputFile = "extend_output.txt",
								 parameter inputFile = "extend_input.txt")
							   ();

reg   clk,reset;
logic [23:0] instr;
logic [1:0] immSrc;
logic [WIDTH-1:0] extImm;
logic [23:0] values[9:0];
integer f, i;

EXTEND #(WIDTH) extender (instr, immSrc, extImm);

always #5 clk=~clk;

//Clock and reset release
initial begin
	$readmemb(inputFile, values);
	clk=0; reset=1; //Clock low at time zero
	@(posedge clk);
	@(posedge clk);
	reset=0;
end

initial begin

	f = $fopen(outputFile,"w");
	@(negedge reset); //Wait for reset to be released
   @(posedge clk);   //Wait for fisrt clock out of reset
	for (i = 0; i<5; i=i+1) begin
		instr = values[i];
		immSrc = values[i+5];
		@(posedge clk);
		$display("instr %d ; immSrc = %b ; extImm = %d", instr, immSrc, extImm);
		$fwrite(f,"%b\n", extImm);
	end
	$fclose(f);
	
end
  
endmodule