
module datapath(
	input clk, clr, stop,
	output wire [7:0] hexOut1, hexOut2,
	output wire [31:0] BMIr0, BMIr1, BMIr2, BMIr3, BMIr4, BMIr5, BMIr6, BMIr7, BMIr8, BMIr9, BMIr10, BMIr11, BMIr12, BMIr13, BMIr14, BMIr15, BMIHI, BMILO, BMIPC, BMIMDR, IRout, memChip
);
wire HIout, LOout, PCout, MDRout, Inportout, Cout;
wire HIen, LOen, PCen, MARen, IRen, Outporten, RAMwrite;
wire [4:0] op;			
wire MDRen, Read, Graen, Graout, Grb, Grc, BAout, CON, reten, run;
wire [31:0] Input;

assign Input = 32'h80;
	
wire [31:0] BMIInport, CSignExt, mData, Output, bussyAout, bussyBout;
wire [63:0] bussyC;
wire [15:0] Raout, Rbout, Rcout, Raen;

wire CFFout;


controlUnit control(Graen, Graout, Grb, Grc, 
HIout, LOout, PCout, MDRout, Inportout, Cout, 
HIen, LOen, PCen, MARen, IRen, Outporten, RAMwrite, MDRen, Read, BAout, CON, reten, run,
op, clk, clr, stop, IRout[31:27]);

//Devices 
reg32 r0(clr, clk, Raen[0], bussyC[31:0], BMIr0); 
reg32 r1(clr, clk, Raen[1], bussyC[31:0], BMIr1); 
reg32 r2(clr, clk, Raen[2], bussyC[31:0], BMIr2);
reg32 r3(clr, clk, Raen[3], bussyC[31:0], BMIr3);
reg32 r4(clr, clk, Raen[4], bussyC[31:0], BMIr4);
reg32 r5(clr, clk, Raen[5], bussyC[31:0], BMIr5);
reg32 r6(clr, clk, Raen[6], bussyC[31:0], BMIr6);
reg32 r7(clr, clk, Raen[7], bussyC[31:0], BMIr7);
reg32 r8(clr, clk, Raen[8], bussyC[31:0], BMIr8);
reg32 r9(clr, clk, Raen[9], bussyC[31:0], BMIr9);
reg32 r10(clr, clk, Raen[10], bussyC[31:0], BMIr10);
reg32 r11(clr, clk, Raen[11], bussyC[31:0], BMIr11);
reg32 r12(clr, clk, Raen[12], bussyC[31:0], BMIr12);
reg32 r13(clr, clk, Raen[13], bussyC[31:0], BMIr13);
reg32 r14(clr, clk, Raen[14], bussyC[31:0], BMIr14);
reg32 r15(clr, clk, Raen[15] | reten, bussyC[31:0], BMIr15);
reg32 PC(clr, clk, (PCen | (CON && CFFout)), bussyC[31:0], BMIPC);
reg32 MAR(clr, clk, MARen, bussyC[31:0], memChip);
reg32 IR(clr, clk, IRen, bussyC[31:0], IRout);
reg32 HI(clr, clk, HIen, bussyC[63:32], BMIHI);
reg32 LO(clr, clk, LOen, bussyC[31:0], BMILO);
reg32 Outport(clr, clk, Outporten, bussyAout, Output);
reg32 Inport(clr, clk, 1, Input, BMIInport);
mdr_reg mdr(clr, clk, MDRen, Read, mData, bussyC[31:0], BMIMDR);
//Bus
bussyB b(BAout ? 32'd0 : BMIr0, BMIr1, BMIr2, BMIr3, BMIr4, BMIr5, BMIr6, BMIr7, BMIr8, BMIr9, BMIr10, BMIr11, BMIr12, BMIr13, BMIr14, BMIr15, BMIHI, BMILO, BMIPC, BMIMDR, BMIInport,
Rbout, HIout, LOout, PCout, MDRout, Inportout,
bussyBout);

ALU a(bussyAout, bussyBout, op, bussyC);

RAM ram(BMIMDR, memChip[8:0], Read, RAMwrite, clk, mData);

SelectEncode SelectEncodeInst(IRout, Graen, Graout, Grb, Grc, Raen, Raout, Rbout, Rcout, CSignExt);

CONFF CFF(clk, bussyC[31:0], IRout[22:19], CFFout);

bussyA BA(BMIr0, BMIr1, BMIr2, BMIr3, BMIr4, BMIr5, BMIr6, BMIr7, BMIr8, BMIr9, BMIr10, BMIr11, BMIr12, BMIr13, BMIr14, BMIr15, CSignExt,
Raout | Rcout, Cout, bussyAout);

Seven_Seg_Display_Out s1(hexOut1, clk, Output[3:0]);
Seven_Seg_Display_Out s2(hexOut2, clk, Output[7:4]);

endmodule
