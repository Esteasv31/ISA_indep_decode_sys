module flopwbTestBench #(parameter WIDTH = 32,
								 parameter outputFile = "outputs/flopwb_output.txt",
								 parameter inputFile = "inputs/flopwb_input.txt")
							   ();
					
logic clk, reset, prsrc, regwrite, memtoreg, PCSrcW, RegWriteW, MemtoRegW;
logic [WIDTH-1:0] Aludata, readData, ReadDataW, ALUOutW;
logic [3:0] wa3m, WA3W;
logic [70:0] values[4:0];
logic [70:0] a;
integer f, i;

FLOPWB #(WIDTH) flopwb (clk, reset, prsrc, regwrite, memtoreg, wa3m, Aludata, readData, ReadDataW, ALUOutW, WA3W, PCSrcW, RegWriteW, MemtoRegW);

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
	for (i = 0; i<5; i=i+1) begin
		a = values[i];
		prsrc = a[70];
		regwrite = a[69];
		memtoreg = a[68];
		wa3m = a[67:64];
		Aludata = a[63:32];
		readData = a[31:0];
		@(posedge clk);
		@(posedge clk);
		$display("PCSrcW = %b ; RegWriteW = %b ; MemtoRegW = %b ; WA3W = %b ; ALUOutW = %b ; ReadDataW = %b ;", PCSrcW, RegWriteW, MemtoRegW, WA3W, ALUOutW, ReadDataW);
		$fwrite(f,"%b\n", {PCSrcW, RegWriteW, MemtoRegW, WA3W, ALUOutW, ReadDataW});
	end
	$fclose(f);
	
end
  
endmodule