module controlUnitTestBench #(parameter WIDTH = 32,
								      parameter outputFile = "outputs/controlUnit_output.txt",
										parameter inputFile = "inputs/controlUnit_input.txt")
									  ();

logic clk, reset, PCcpu, branch, encode, branchMux, PCcompress, inputBuff, tableMux, outMux, PCintern, outBuff1, outBuff2;
logic [2:0] a;
logic [WIDTH-1:0] values[4:0];
integer f, i;

ControlUnit conUnit (clk, reset, PCcpu, branch, encode, branchMux, PCcompress, inputBuff, tableMux, outMux, PCintern, outBuff1, outBuff2);

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
		PCcpu = a[2];
		branch = a[1];
		encode = a[0];
		@(posedge clk);
		$display("controlUnit %d - %d - %d = %d - %d - %d - %d - %d - %d - %d - %d", PCcpu, branch, encode, branchMux, PCcompress, inputBuff, tableMux, outMux, PCintern, outBuff1, outBuff2);
		$fwrite(f,"%b\n", {branchMux, PCcompress, inputBuff, tableMux, outMux, PCintern, outBuff1, outBuff2});
	end
	$fclose(f);
	
end
  
endmodule