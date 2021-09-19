// SIMPLE BUFFER
module BUFFER #(parameter WIDTH = 32)
					(input logic [WIDTH-1:0] a,
					output logic [WIDTH-1:0] b);
				  
assign b = a;

endmodule 

// FIFO BUFFER
module FIFObuffer #(parameter WIDTH = 32,
						  parameter SIZE = 2)
						(input logic clk, RD, WR, EN, Rst,
						 input logic [WIDTH-1:0] dataIn,
						output logic EMPTY, FULL,	
						output logic [WIDTH-1:0] dataOut);
				  
logic [2:0]  Count = 0; 
logic [31:0] FIFO [0:SIZE-1]; 
logic [2:0]  readCounter = 0, writeCounter = 0; 

assign EMPTY = (Count == 0) ? 1'b1 : 1'b0; 

assign FULL = (Count == SIZE) ? 1'b1 : 1'b0;

always @(posedge clk) begin

	if (EN==0); 
	
	else begin 
		if (Rst) begin 
			readCounter = 0; 
			writeCounter = 0; 
		end 
		else if (RD == 1'b1 && Count != 0) begin 
			dataOut  = FIFO[readCounter]; 
			readCounter = readCounter+1; 
		end 
	   else if (WR == 1'b1 && Count < SIZE) begin
			FIFO[writeCounter]  = dataIn; 
			writeCounter  = writeCounter+1; 
		end 
		else; 
	end 
	
	if (writeCounter == SIZE) writeCounter = 0; 
	else if (readCounter == SIZE) readCounter = 0; 
	else;

	if (readCounter > writeCounter) begin 
		Count=readCounter-writeCounter; 
	end 
	else if (writeCounter > readCounter) 
		Count=writeCounter-readCounter; 
	else; 
end

endmodule
