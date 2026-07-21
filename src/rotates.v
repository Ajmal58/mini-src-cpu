module ror(input wire[31:0] A, numBits, output wire[31:0] result);

		reg bit;
		reg[31:0] a;
		integer i;
		
always @* begin
	a = A;

	for(i = 0; i < 32; i = i+1) begin
	
		if (i < numBits) begin
			bit = a[0];
			a = a >> 1;
			a[31] = bit;
		end
		
	end

end

	assign result = a;
	
endmodule


module rol(input wire[31:0] A, numBits, output wire[31:0] result);

		reg bit;
		reg[31:0] a;
		integer i;
		
always @* begin
	a = A;

	for(i = 0; i < 32; i = i+1) begin
	
		if (i < numBits) begin
			bit = a[31];
			a = a << 1;
			a[0] = bit;
		end
		
	end
	
end

	assign result = a;
	
endmodule
