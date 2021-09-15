module regfileTestBench #(parameter WIDTH = 32,
							  parameter outputFile = "outputs/regFile_output.txt",
							  parameter inputFile = "inputs/regFile_input.txt")
						    ();

logic clk, reset, we3;
logic [12:0] a;
logic [3:0] ra1, ra2, wa3;
logic [WIDTH-1:0] wd3, r15, rd1, rd2;
logic [WIDTH-1:0] values[9:0];
integer f, i;

REGFILE #(WIDTH) regfile (~clk, we3, ra1, ra2, wa3, wd3, r15, rd1, rd2);

always #5 clk=~clk;

//Clock and reset release
initial begin
	$readmemb(inputFile, values);
	clk=0; reset=1; r15=32'b0; //Clock low at time zero
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
		we3 = a[12];
		ra1 = a[11:8];
		ra2 = a[7:4];
		wa3 = a[3:0];
		wd3 = values[i+5];
		@(posedge clk);
		$display("we3 = %b ; ra1 = %d ; ra2 = %d ; wa3 = %d ; wd3 = %d ; r15 = %h ;rd1 = %d ; rd2 = %d", we3, ra1, ra2, wa3, wd3, r15, rd1, rd2);
		$fwrite(f,"%b\n", rd1);
		$fwrite(f,"%b\n", rd2);
		r15 = r15 + 32'd4;
	end
	$fclose(f);
	
end
  
endmodule