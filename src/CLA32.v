module CLA32(input wire [31:0] A, B, input wire Cin, output wire [32:0] Sum);

	//wire [3:0] G0, G1, G2, G3, P0, P1, P2, P3;
	wire [7:0] carry;
	wire [31:0] S;
	
	CLA4	CLA0(A[3:0], B[3:0], Cin, carry[0], S[3:0]);
	CLA4	CLA1(A[7:4], B[7:4], carry[0], carry[1], S[7:4]);
	CLA4	CLA2(A[11:8], B[11:8], carry[1], carry[2], S[11:8]);
	CLA4	CLA3(A[15:12], B[15:12], carry[2], carry[3], S[15:12]);
	CLA4	CLA4(A[19:16], B[19:16], carry[3], carry[4], S[19:16]);
	CLA4	CLA5(A[23:20], B[23:20], carry[4], carry[5], S[23:20]);
	CLA4	CLA6(A[27:24], B[27:24], carry[5], carry[6], S[27:24]);
	CLA4	CLA7(A[31:28], B[31:28], carry[6], carry[7], S[31:28]);

	assign CO = carry[7];
	assign Sum = {CO, S};
	
	
	
endmodule
