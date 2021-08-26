module HAZARDU (input logic RegWriteW, RegWriteM, MemtoRegE,
					input logic Match_1E_M, Match_1E_W, Match_2E_M, Match_2E_W, 
					output logic [1:0] ForwardAE, ForwardBE,
					input logic Match_12D_E,
					output logic LDRstall);
					
assign LDRstall = Match_12D_E & MemtoRegE;
					
always_comb

	if(Match_1E_M & RegWriteM) begin ForwardAE = 10;				// SrcAE = ALUOutM
	end else if (Match_1E_W & RegWriteW) begin ForwardAE = 01; 	// SrcAE = ResultW
	end else begin ForwardAE = 00; end									// SrcAE from regfile

always_comb

	if(Match_2E_M & RegWriteM) begin ForwardBE = 10;				// SrcAE = ALUOutM
	end else if (Match_2E_W & RegWriteW) begin ForwardBE = 01; 	// SrcAE = ResultW
	end else begin ForwardBE = 00; end									// SrcAE from regfile

endmodule
