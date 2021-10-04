module pc_decompresor_buffer_testbench ();

logic clk;
logic reset;
logic [31:0] PCcpu, DecompressInstr;
integer f, i;
realtime time_s1 = 0.0;
realtime time_s2 = 0.0;

// instantiate device to be tested
topBuffer #(32, 32'b100, 4'b1111, 4, "inputs/compress_tokensTable_dot_and_cross_product.dat", "inputs/compress_dot_and_cross_product.dat", 32, 77) decompressor_buff (clk, reset);

// generate clock to sequence tests
always #20 clk = ~clk;

// initialize test
initial begin
	$timeformat(-9, 2, " ns", 10);
	clk=0; reset=1; //Clock low at time zero
	@(posedge clk);
	@(posedge clk);
	reset=0;
end
	
initial begin

	f = $fopen("outputs/decompresorBufferTestbench_output.txt","w");
	@(negedge reset); //Wait for reset to be released
	
	time_s1 = $realtime ;
	$display("Time 1: %t", time_s1);
	
	for (i = 0; i<115; i=i+1) begin
		@(posedge clk); 
		$display("PC_cpu = %h & DecompressInstr = %h ", PCcpu, DecompressInstr);
		$fwrite(f,"%h\n", DecompressInstr);
		if(DecompressInstr === 32'h1EFF2FE1 && PCcpu === 32'h000001BC) begin
			time_s2 = $realtime;
			$display("Time Diff      : %t", time_s2 - time_s1);
			$display("Simulation succeeded");
			$stop;
		end else if (PCcpu === 32'h000001C0) begin
			time_s2 = $realtime;
			$display("Time Diff      : %t", time_s1 - time_s2);
			$display("Simulation failed");
			$stop;
		end
	end
	$fclose(f);
	
end

endmodule
          