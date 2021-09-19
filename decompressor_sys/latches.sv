module SRlatch #(parameter WIDTH = 32)
					 (input logic [WIDTH-1:0] S, R,
					 output logic [WIDTH-1:0] Q, Qbar);
				  
assign Q = R ^ Qbar;
assign Qbar = S ^ Q;

endmodule 

module Dlatch #(parameter WIDTH = 32)
					 (input logic EN,
					  input logic [WIDTH-1:0] D,
					 output logic [WIDTH-1:0] Q, Qbar);
				  
always @(D or EN)
	if(EN) begin
		Q <= D;
		Qbar <= ~D;
	end

endmodule 