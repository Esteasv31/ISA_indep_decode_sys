module flopclrTestBench #(parameter WIDTH = 32,
								  parameter outputFile = "outputs/flopclr_output.txt",
								  parameter inputFile = "inputs/flopclr_input.txt")
							    ();
					
logic clk, reset, clr, pcsrcD, regwrited, memtoregd, memwrited, branchd, alusrcd, PCSrcE, RegWriteE, MemWriteE, MemtoRegE, ALUSrcE, BranchE;
logic [WIDTH-1:0] rd1, rd2, extImm, RD1, RD2, EXTIMM;
logic [3:0] wa3d, flagsd, condd, FlagsE, CondE, WA3E, ra1d, ra2d, RA1E, RA2E;
logic [1:0] flagwrited, alucontrold, FlagWriteE, ALUControlE;
logic [127:0] values[4:0];
logic [127:0] a;
integer f, i;

FLOPCLR #(WIDTH) flopclr (clk, reset, clr, rd1, rd2, extImm, wa3d, pcsrcD, regwrited, memtoregd, memwrited, branchd, alusrcd, flagwrited, alucontrold, flagsd, condd,
									FlagsE, CondE, FlagWriteE, ALUControlE, PCSrcE, RegWriteE, MemWriteE, MemtoRegE, ALUSrcE, BranchE, WA3E, RD1, RD2, EXTIMM, ra1d, ra2d, RA1E, RA2E);

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
		clr = a[126];
		rd1 = a[125:94];
		rd2 = a[93:62];
		extImm = a[61:30];
		wa3d = a[29:26];
		pcsrcD = a[25];
		regwrited = a[24];
		memtoregd = a[23];
		memwrited = a[22];
		branchd = a[21];
		alusrcd = a[20];
		flagwrited = a[19:18];
		alucontrold = a[17:16];
		flagsd = a[15:12];
		condd = a[11:8];
		ra1d = a[7:4];
		ra2d = a[3:0];
		@(posedge clk);
		@(posedge clk);
		$fwrite(f,"%b\n", {RD1, RD2, EXTIMM, WA3E, PCSrcE, RegWriteE, MemtoRegE, MemWriteE, BranchE, ALUSrcE, FlagWriteE, ALUControlE, FlagsE, CondE, RA1E, RA2E});
	end
	$fclose(f);
	
end
  
endmodule 