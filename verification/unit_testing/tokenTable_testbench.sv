module tokenTableTestBench #(parameter WIDTH = 32,
									  parameter SIZE = 64,
									  parameter FILE = "memfile.dat",
									  parameter outputFile = "outputs/tableToken_output.txt",
									  parameter inputFile = "inputs/tableToken_input.txt")
									 ();

reg   clk, reset, en;
logic [WIDTH-1:0] a, b, data, rd1, rd2;
logic [WIDTH-1:0] values[19:0];
integer f, i;

tokenTable #(WIDTH, SIZE, FILE) tokenTable_ (a, b, data, clk, en, rd1, rd2);

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
		en = values[i];
		a = values[i+5];
		b = values[i+10];
		data = values[i+15];
		@(posedge clk);
		$display("token table %d - %d - %d - %d = %d - %d", en, a, b, data, rd1, rd2);
		$fwrite(f,"%h\n", rd1);
		$fwrite(f,"%h\n", rd2);
	end
	$fclose(f);
	
end
  
endmodule
