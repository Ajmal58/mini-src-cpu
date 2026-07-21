module shl(input wire[31:0] A, numBits, output wire[31:0] result);
	
		assign result = A << numBits;
	
endmodule

module shr(input wire[31:0] A, numBits, output wire[31:0] result);
	
		assign result = A >> numBits;
	
endmodule

module shra(input signed [31:0] A, numBits, output wire[31:0] result);
	
		assign result = A >>> numBits;
	
endmodule
