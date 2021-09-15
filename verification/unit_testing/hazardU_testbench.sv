module hazardUTestBench #(parameter WIDTH = 32,
								  parameter outputFile = "outputs/hazardU_output.txt",
								  parameter inputFile = "inputs/hazardU_input.txt")
							    ();

logic clk, reset, RegWriteW, RegWriteM, MemtoRegE, Match_1E_M, Match_1E_W, Match_2E_M, Match_2E_W, Match_12D_E, LDRstall;
logic [1:0] ForwardAE, ForwardBE;
logic [7:0] values[5:0], a;
integer f, i;

HAZARDU hazardu (RegWriteW, RegWriteM, MemtoRegE, Match_1E_M, Match_1E_W, Match_2E_M, Match_2E_W, ForwardAE, ForwardBE, Match_12D_E, LDRstall);

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
	for (i = 0; i<6; i=i+1) begin
		a = values[i];
		
		RegWriteW = a[7];
		RegWriteM = a[6];
		MemtoRegE = a[5];
		Match_1E_M = a[4];
		Match_1E_W = a[3];
		Match_2E_M = a[2];
		Match_2E_W = a[1];
		Match_12D_E = a[0];
		$display("ForwardAE = %b ; ForwardBE = %d ; LDRstall = %d ;", ForwardAE, ForwardBE, LDRstall);
		@(posedge clk);
		$fwrite(f,"%b\n", {ForwardAE, ForwardBE, LDRstall});
	end
	$fclose(f);
	
end
  
endmodule