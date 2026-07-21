module SelectEncode(input wire [31:0] IR, input Graen, Graout, Grb, Grc,
output reg [15:0] Raen, 
output reg [15:0] Raout, Rbout, Rcout,
output [31:0] C_sign_extended
);

always@(*) begin
	Raen[15:0] = 'b0;
	Raout[15:0] = 'b0;
	Rbout[15:0] = 'b0;
	Rcout[15:0] = 'b0;
	if(Graout)
		Raout[IR[26:23]]=1;
	else if (Graen)
		Raen[IR[26:23]]=1;


	if(Grb)
		Rbout[IR[22:19]]=1;

	if(Grc)
		Rcout[IR[18:15]]=1;
end

assign C_sign_extended = $signed(IR[18:0]);

endmodule
