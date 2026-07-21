module reg32 (
	input clr, clk, en, 
	input [31:0] d,
	output wire [31:0] q
);
reg [31:0]f;
initial f = 32'b0;
always @ (posedge clk)
		begin
			if (clr) begin
				f <= 32'b0;
			end 
			else if (en) begin
				f <= d;
			end
		end
	assign q = f[31:0];
endmodule
