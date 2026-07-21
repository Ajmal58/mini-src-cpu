module ALU(input wire [31:0] A, B, input wire[4:0] op, output wire[63:0] res);	
	wire [31:0] and_result, or_result, neg_result, not_result, add_result, sub_result, shr_result, shra_result, shl_result, shla_result, 
	ror_result, rol_result, incPC_result;
	
	wire[63:0] mul_result, div_result;
	reg [63:0] result;
	
	and_or and_inst(A, B, 1, and_result);
	and_or or_inst(A, B, 0, or_result);
	notOp not_inst(B, not_result);
	neg 	neg_inst(B, neg_result);
	CLA32 add_inst(A, B, 0, add_result);
	CLA32 sub_inst(B, (~A), 1, sub_result);
	mul32 mul_inst(A, B, mul_result);
	shl shl_inst(B, A, shl_result);
	shr shr_inst(B, A, shr_result);
	shra shra_inst(B, A, shra_result);
	div32 div_instance(A, B, div_result);
	ror	ror_instance(B, A, ror_result); 
	rol	rol_instance(B, A, rol_result);
	CLA32 inc_instance(32'd1, B, 0, incPC_result);
	
	always @(*) begin
		case(op)
			0	:	result = and_result;
			1	:	result = or_result;
			2 	:	result = neg_result;
			3	:	result = not_result;
			4	: 	result = $signed(add_result);
			5	: 	result = $signed(sub_result);
			6	:	result = mul_result;
			7	:	result = div_result;
			8	:	result = shr_result;
			9	:	result = shra_result;
			10	:	result = shl_result;
			11	:	result = ror_result;
			12	: 	result = rol_result;
			13 :  result = incPC_result;
			14 : 	result = B;
			15 :	result = A;
	 
			default: result = or_result;
		endcase
	end
	assign res = result;
endmodule
