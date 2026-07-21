module bussyB ( 
//Mux 
input [31:0] BMIr0, BMIr1, BMIr2, BMIr3, BMIr4, BMIr5, BMIr6, BMIr7, BMIr8, BMIr9, BMIr10, BMIr11, BMIr12, BMIr13, BMIr14, BMIr15,  BMIHI, BMILO, BMIZHI, BMIZLO, BMIPC, BMIMDR, BMIInport, CSignExt,
//Encoder 
input [15:0] rout, 
input HIout, LOout, ZHIout, ZLOout, PCout, MDRout, Inportout, Cout,

output wire [31:0] BusMuxout
);

reg [31:0]q;

always @ (*) begin
	if (rout[0]) q = BMIr0;
	if (rout[1]) q = BMIr1;
	if (rout[2]) q = BMIr2;
	if (rout[3]) q = BMIr3;
	if (rout[4]) q = BMIr4;
	if (rout[5]) q = BMIr5;
	if (rout[6]) q = BMIr6;
	if (rout[7]) q = BMIr7;
	if (rout[8]) q = BMIr8;
	if (rout[9]) q = BMIr9;
	if (rout[10]) q = BMIr10;
	if (rout[11]) q = BMIr11;
	if (rout[12]) q = BMIr12;
	if (rout[13]) q = BMIr13;
	if (rout[14]) q = BMIr14;
	if (rout[15]) q = BMIr15;
	if (PCout) q = BMIPC;
	if (HIout) q = BMIHI;
	if (LOout) q = BMILO;
	if (ZHIout) q = BMIZHI;
	if (ZLOout) q = BMIZLO;
	if (MDRout) q = BMIMDR;
	if (Inportout) q = BMIInport;
	if (Cout) q = CSignExt;
	
end
assign BusMuxout = q[31:0];
endmodule
