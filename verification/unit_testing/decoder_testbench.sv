module decoderTestBench #(parameter WIDTH = 32,
								  parameter outputFile = "decoder_output.txt",
								  parameter inputFile = "decoder_input.txt")
								 ();

logic clk, reset, pcs, regW, memW, memToReg, aluSrc, branch;
logic [WIDTH-1:0] a;
logic [WIDTH-1:0] values[22:0];
integer f, i;

logic [1:0] op, flagW, immSrc, regSrc, aluControl;
logic [5:0] funct;
logic [3:0] rd;
					
DECODER decoder (op, funct, rd, flagW, pcs, regW, memW, memToReg, aluSrc, immSrc, regSrc, aluControl, branch);

always #5 clk=~clk;

//Clock and reset release
initial begin
	$readmemh(inputFile, values);
	clk=0; reset=1; //Clock low at time zero
	@(posedge clk);
	@(posedge clk);
	reset=0;
end

initial begin

	f = $fopen(outputFile,"w");
	@(negedge reset); //Wait for reset to be released
   @(posedge clk);   //Wait for fisrt clock out of reset
	for (i = 0; i<23; i=i+1) begin
		a = values[i];
		
		op = a[27:26];
		funct = a[25:20];
		rd = a [15:12];
		
		@(posedge clk);
		$display("A %d ; RD %b", a, rd);
		$fwrite(f,"%b\n", {flagW, pcs, regW, memW, memToReg, aluSrc, immSrc, regSrc, aluControl, branch});
	end
	$fclose(f);
	
end
  
endmodule