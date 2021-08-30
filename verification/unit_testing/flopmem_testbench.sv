module flopmemTestBench #(parameter WIDTH = 32,
								  parameter outputFile = "flopmem_output.txt",
								  parameter inputFile = "flopmem_input.txt")
							    ();
					
logic clk, reset, en, pcsrc, regW, memW, memtoreg, PCSrcM, RegWriteM, MemWriteM, MemtoRegM;
logic [WIDTH-1:0] aluResult, Wdata, ALUResultM, WriteDataM;
logic [3:0] wa3e, WA3M;
logic [71:0] values[4:0];
logic [71:0] a;
integer f, i;

FLOPMEM #(WIDTH) flopmem (clk, reset, aluResult, Wdata, wa3e, pcsrc, regW, memW, memtoreg, PCSrcM, RegWriteM, MemWriteM, MemtoRegM, WA3M, ALUResultM, WriteDataM);

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
		aluResult = a[71:40];
		Wdata = a[39:8];
		wa3e = a[7:4];
		pcsrc = a[3];
		regW = a[2];
		memW = a[1];
		memtoreg  = a[0];
		@(posedge clk);
		$fwrite(f,"%b\n", {ALUResultM, WriteDataM, WA3M,  PCSrcM, RegWriteM, MemWriteM, MemtoRegM});
	end
	$fclose(f);
	
end
  
endmodule