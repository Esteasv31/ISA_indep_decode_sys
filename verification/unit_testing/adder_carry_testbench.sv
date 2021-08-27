module adderCarryTestBench #(parameter WIDTH = 32,
									  parameter outputFile = "addCarry_output.txt",
									  parameter inputFile = "addCarry_input.txt")
									 ();

logic clk,reset, cin, cout;
logic [WIDTH-1:0] a, b, c;
logic [WIDTH-1:0] values[14:0];
integer f, i;

ADD_CARRY #(WIDTH) adderCarry (a, b, cin, c, cout);

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
		b = values[i+5];
		cin = values[i + 10];
		@(posedge clk);
		$display("ADD %d + %d + %d = %d ; %d", a, b, cin, c, cout);
		$fwrite(f,"%b\n",   c);
		$fwrite(f,"%b\n",   cout);
	end
	$fclose(f);
	
end
  
endmodule