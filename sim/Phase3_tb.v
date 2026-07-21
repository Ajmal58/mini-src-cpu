`timescale 1ns/10ps
module Phase3_tb;
	reg clk, clr, stop;
	initial begin
		clk = 0;
		forever #10 clk = ~ clk;
	end
	
	initial begin
		clr <=1;
		stop <=0;
		#10 clr <=0;
	end
	
	wire [31:0]  hexOut1, hexOut2, BMIr0, BMIr1, BMIr2, BMIr3, BMIr4, BMIr5, BMIr6, BMIr7, BMIr8, BMIr9, BMIr10, BMIr11, BMIr12, BMIr13, BMIr14, BMIr15, BMIHI, BMILO, BMIPC, BMIMDR, IRout, memChip;
	datapath d(clk, clr, stop, hexOut1, hexOut2, BMIr0, BMIr1, BMIr2, BMIr3, BMIr4, BMIr5, BMIr6, BMIr7, BMIr8, BMIr9, BMIr10, BMIr11, BMIr12, BMIr13, BMIr14, BMIr15, BMIHI, BMILO, BMIPC, BMIMDR, IRout, memChip);

endmodule
