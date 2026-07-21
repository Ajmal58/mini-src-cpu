module div32(input wire [31:0] Q, M, output wire [63:0] result);

	reg[31:0] q, A;
	reg[31:0] posM, negM;
	reg[63:0] r;
	integer i, negRes;

always @* begin

	if(M[31] == 1'b0) begin
		posM = M;
		negM = -M;
	end
	else begin
		posM = -M;
		negM = M;
	end
	
	if(Q[31] ^ M[31]) negRes = 1;
	else negRes = 0;
	
	if(Q[31] == 1'b0) q = Q;
	else q = -Q;
	
	A = 32'h0;
	
	for(i = 0; i < 32; i = i+1) begin
		A = A << 1;
		A[0] = q[31];
		q = q << 1;
		
		if(A[31] == 0) A = A + negM;
		else A = A + posM;
		
		if(A[31] == 0) q[0] = 1'b1;
		else q[0] = 1'b0;	
	end
	
	if(A[31] == 1) A = A + posM;
	
	
	if(negRes == 1) q = -q;	
	
	r[63:32] = A;
	r[31:0] = q;
	
end
	
assign result = r;

endmodule

