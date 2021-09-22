module decompresor_latch_testbench();

logic clk;
logic reset;
logic [31:0] PCcpu, DecompressInstr;
integer f, i;

// instantiate device to be tested
topLatch #(32, 32'b100, 4'b1111, 4, "inputs/compress_tokensTable_dot_and_cross_product.dat", "inputs/compress_dot_and_cross_product.dat", 32, 77) decompressor_latch (clk, reset, PCcpu, DecompressInstr);

// generate clock to sequence tests
always #20 clk = ~clk;

// initialize test
initial begin
	PCcpu = 32'd0;
	clk=0; reset=1; //Clock low at time zero
	@(posedge clk);
	@(posedge clk);
	reset=0;
end
	
initial begin

	f = $fopen("outputs/decompresor_Latch_Testbench.txt","w");
	@(negedge reset); //Wait for reset to be released
   @(posedge clk);   //Wait for fisrt clock out of reset
	for (i = 0; i<115; i=i+1) begin
		@(posedge clk); 
		$display("PC_cpu = %h & DecompressInstr = %h ", PCcpu, DecompressInstr);
		$fwrite(f,"%h\n", DecompressInstr);
		if(DecompressInstr === 32'h1EFF2FE1 && PCcpu === 32'h000001BC) begin
			$display("Simulation succeeded");
			$stop;
		end else if (PCcpu === 32'h000001C0) begin
			$display("Simulation failed");
			$stop;
		end
		PCcpu = PCcpu + 32'd4;
	end
	$fclose(f);
	
end

endmodule

