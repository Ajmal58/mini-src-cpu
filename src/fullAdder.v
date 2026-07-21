module fullAdder(input wire [0:0] C, X, Y, output wire [0:0] carry, sum);

	assign carry = (Y & C) | (X & C) | (X & Y);
	assign sum = X ^ Y ^ C;
	
endmodule
