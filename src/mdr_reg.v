module mdr_reg (
	input clr, clk, MDRen, read, 
	input [31:0] Mdatain,
	input [31:0] BusMuxout,
	output wire [31:0] q
);

reg32 r(clr, clk, MDRen, read ? Mdatain : BusMuxout, q);
endmodule
