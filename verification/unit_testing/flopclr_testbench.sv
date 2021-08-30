module flopclrTestBench #(parameter WIDTH = 32,
								  parameter outputFile = "flopclr_output.txt",
								  parameter inputFile = "flopclr_input.txt")
							    ();
					
logic clk, reset, clr, pcsrcD, regwrited, memtoregd, memwrited, branchd, alusrcd, PCSrcE, RegWriteE, MemWriteE, MemtoRegE, ALUSrcE, BranchE;
logic [WIDTH-1:0] rd1, rd2, extImm, RD1, RD2, EXTIMM;
logic [3:0] wa3d, flagsd, condd, FlagsE, CondE, WA3E, ra1d, ra2d, RA1E, RA2E;
logic [1:0] flagwrited, alucontrold, FlagWriteE, ALUControlE;
logic [71:0] values[4:0];
logic [71:0] a
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
   @(posedge clk);   //Wait for fisrt clock out of reset
	for (i = 0; i<5; i=i+1) begin
		a = values[i];
		
		clr = a[125];
		rd1 = a[124:93];
		rd2 = a[92:61];
		extImm = a[60:29];
		wa3d = a[28:25];
		pcsrcD = a[24];
		regwrited = a[23];
		memtoregd = a[22];
		memwrited = a[21];
		branchd = a[20];
		alusrcd = a[19];
		flagwrited = a[18:17];
		alucontrold = a[16:15];
		flagsd = a[14:11];
		condd = a[10:7];
		ra1d = a[7:4];
		ra2d = a[3:0];
		
		@(posedge clk);
		$fwrite(f,"%b\n", {RD1, RD2, EXTIMM, WA3E, PCSrcE, RegWriteE, MemtoRegE, MemWriteE, BranchE, ALUSrcE, FlagWriteE, ALUControlE, FlagsE, CondE, RA1E, RA2E});
	end
	$fclose(f);
	
end
  
endmodule 