`timescale 1ns/10ps
module br_tb;

reg HIout, LOout, PCout, MDRout, Inportout, Cout;
reg HIen, LOen, PCen, MARen, IRen, MDRen, Read, Outporten, RAMwrite;
reg Graen, Graout, Grb, Grc, BAout, CON, reten;
reg clk, clr;
reg [31:0] Input;
parameter Default = 4'b0000, Reg_loada = 4'b0001, Reg_loadb = 4'b0010, Reg_loadc = 4'b0011, Reg_loadd = 4'b0100, Reg_loade = 4'b0101, Reg_loadf = 4'b0110, T0 = 4'b0111,T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
reg [3:0] Present_state = Default;
reg[4:0] op;
datapath DUT(clk, clr, HIout, LOout, PCout, MDRout, Inportout, Cout, 
HIen, LOen, PCen, MARen, IRen, Outporten, RAMwrite,
op, MDRen, Read, Graen, Graout, Grb, Grc, BAout, CON, reten, Input);
// add test logic here
initial
	begin
		clk = 0;
		forever #10 clk = ~ clk;
	end
always @(posedge clk) // finite state machine; if clock rising-edge
	begin
		case (Present_state)
			Default : Present_state = Reg_loada;
			Reg_loada : Present_state = Reg_loadb;
			Reg_loadb : Present_state = Reg_loadc;
			Reg_loadc : Present_state = Reg_loadd;
			Reg_loadd : Present_state = Reg_loade;
			Reg_loade : Present_state = Reg_loadf;
			Reg_loadf : Present_state = T0;
			T0 : Present_state = T1;
			T1 : Present_state = T2;
			T2 : Present_state = T3;
			T3 : Present_state = T4;
			T4 : Present_state = T5;
			T5 : Present_state = T6;
			T6 : Present_state = T7;
			
		endcase
	end

always @(Present_state) // do the required job in each state
	begin
		case (Present_state) // assert the required signals in each clock cycle
			Default: begin	
				PCout<= 0; MDRout<= 0;Inportout<= 0;Cout<= 0;
				HIen<= 0;LOen<= 0;PCen<=0;MARen<=0;IRen<=0;MDRen<=0;Read<=0;Outporten<= 0;RAMwrite<= 0;
				Graout<= 0;Graen<= 0;Grb<= 0;Grc<= 0;BAout<= 0; Input <= 32'hBEEEEEEF;
				op <= 4'b0000;
				clr<= 1;
				#10 clr <= 0;
			end
			Reg_loada: begin
				#10 PCout = 1; MARen = 1; 
				#10 MARen <= 0; PCout <= 0; 
			end
			Reg_loadb: begin
				#10 Read <= 1; MDRen <= 1; PCout<=1; PCen <= 1; op <= 4'd14;
				#10 Read <= 0; MDRen <= 0; PCout<=0; PCen <= 0; 
			end
			Reg_loadc: begin
				#10 MDRout <= 1; IRen <= 1; op <= 4'd15;
				#10 MDRout <= 0; IRen <= 0;
			end
			Reg_loadd: begin
				#10 Grb <= 1; BAout <= 1; Cout <=1; op <= 4'd4; Graen <=1;
				#10 Grb <= 0; BAout <= 0; Cout <=0; Graen <=0;
			end
			Reg_loade: begin
				
			end
			Reg_loadf: begin
				
			end
			T0: begin
				#10 PCout <= 1; MARen <= 1; op <= 4'd15;
				#10 MARen <= 0; PCout <= 0; 
			end
			T1: begin
				#10 Read <= 1; MDRen <= 1; PCout<=1; PCen <= 1; op <= 4'd14;
				#10 Read <= 0; MDRen <= 0; PCout<=0; PCen <= 0;
			end
			T2: begin
				#10 MDRout <= 1; IRen <= 1; op <= 4'd15;
				#10 MDRout <= 0; IRen <= 0;
			end
			T3: begin
				/*
				Op Codes:
				
				Regload(R5): 02800000
				Negative: 0287FFFF 
				
				brzr: 9A800014
				brnz:	9AA00014
				brpl:	9AC00014
				brmi:	9AE00014
				*/
				#10 Graout <= 1; op <= 5'd16; 
				#10 Graout <= 0; 
			end
			T4: begin
				#10 PCout <= 1; BAout <= 1; Cout <=1; CON <= 1; op <= 4'd4;
				#10 PCout <= 0; BAout <= 0; Cout <=0; CON <= 0;
			end
			T5: begin
				
			end
			T6: begin
			end
			T7: begin
			end
		endcase
	end
endmodule
