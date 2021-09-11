module condcheckTestBench #(parameter WIDTH = 32,
									 parameter outputFile = "condCheck_output.txt",
									 parameter inputFile = "condCheck_input.txt")
								   ();

logic clk,reset;
logic [3:0] Cond, Flags;
logic CondEx;
logic [3:0] values[31:0];
integer f, i;

CONDCHECK condchecker (Cond, Flags, CondEx);

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
	for (i = 0; i<16; i=i+1) begin
		Cond = values[i];
		Flags = values[i+16];
		@(posedge clk);
		$display("CondCheck %b ; Flags %b ; CondEx %b", Cond, Flags, CondEx);
		$fwrite(f,"%b\n",   CondEx);
	end
	$fclose(f);
	
end
  
endmodule