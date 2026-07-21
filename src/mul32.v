module mul32(input wire [31:0] A, B, output wire [63:0] result);

	reg signed [15:0] booth[0:15];
	reg[63:0] sum = 64'b0;
	integer i;	
	wire[32 + 1:0]q = {B[31], B, 1'b0};
	
	wire [63:0] notA = $signed(~A + 1'b1);
	wire [63:0] posA = $signed(A);

always @* begin
		sum = 64'b0;
		for(i = 0; i < 32; i = i+2) begin
				if({q[i+2], q[i+1], q[i]} == 3'b000|| {q[i+2], q[i+1], q[i]} == 3'b111) booth[i/2] = 0;
				else if ({q[i+2], q[i+1], q[i]} == 3'b001|| {q[i+2], q[i+1], q[i]} == 3'b010) booth[i/2] = 1;
				else if ({q[i+2], q[i+1], q[i]} == 3'b101|| {q[i+2], q[i+1], q[i]} == 3'b110) booth[i/2] = -1;
				else if ({q[i+2], q[i+1], q[i]} == 3'b011) booth[i/2] = 2;
				else if ({q[i+2], q[i+1], q[i]} == 3'b100) booth[i/2] = -2;	
		end
			
		for(i = 0; i <= 30; i = i+2) begin
			if(booth[i/2] == -1) sum = sum + (notA << i);	
			else if (booth[i/2] == 1) sum = sum + (posA << i);
			else if	(booth[i/2] == 2)	sum = sum + ((posA<<1)<<i);
			else if	(booth [i/2] == -2) sum = sum + ((notA<<1)<<i);
		end
end
	

	
assign result = sum;
	
endmodule
