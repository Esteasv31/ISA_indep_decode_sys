module aluTestBench #(parameter WIDTH = 32,
							 parameter outputFile = "alu_output.txt",
							 parameter inputFile = "alu_input.txt")
						   ();

logic clk,reset;
logic [WIDTH-1:0] a, b, c;
logic [1:0] control;
logic [3:0] flags;
logic [WIDTH-1:0] values[14:0];
integer f, i;

ALU #(WIDTH) adder (a, b, control, c, flags);

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
		a = values[i];
		b = values[i+5];
		control = values[i+10];
		@(posedge clk);
		$display("Control %b ; ALU %b op %b = %b ; flags %b", control, a, b, c, flags);
		$fwrite(f,"%b\n", c);
		$fwrite(f,"%b\n", flags);
	end
	$fclose(f);
	
end
  
endmodule