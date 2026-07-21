module notOp(input wire [31:0] A, output wire [31:0] result);

	assign result = ~A;
	
endmodule

module neg(input wire [31:0] A, output wire [31:0] result);

    assign result = -A;
    
endmodule
