module condlogicTestBench #(parameter WIDTH = 32,
									 parameter outputFile = "outputs/condLogic_output.txt",
									 parameter inputFile = "inputs/condLogic_input.txt")
								   ();

logic clk,reset;
logic [3:0] Cond, ALUFlags, prevFlags;
logic [1:0] FlagW;
logic PCS, RegW, MemW;
logic [16:0] values[13:0];
logic [16:0] temp, res;
integer f, i;
logic PCSrc, RegWrite, MemWrite, CondEx;
logic [3:0] FlagsX;

CONDLOGIC condlogic (clk, reset, Cond, ALUFlags, prevFlags, FlagW, PCS, RegW, MemW, PCSrc, RegWrite, MemWrite, CondEx, FlagsX);

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
	for (i = 0; i<14; i=i+1) begin
	
		temp = values[i];
		
		Cond = temp[16:13];
		ALUFlags = temp[12:9];
		prevFlags = temp[8:5];
		FlagW = temp[4:3];
		PCS = temp[2];
		RegW = temp[1];
		MemW = temp[0];
		
		@(posedge clk);
		$display("data = %b %b %b %b %b %b %b ; res = %b %b %b %b %b", Cond, ALUFlags, prevFlags, FlagW, PCS, RegW, MemW, PCSrc, RegWrite, MemWrite, CondEx, FlagsX);
		$fwrite(f,"%b\n", {PCSrc, RegWrite, MemWrite, CondEx, FlagsX});
	end
	$fclose(f);
	
end
  
endmodule