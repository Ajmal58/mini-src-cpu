`timescale 1ns/10ps
module Phase2TB;

reg HIout, LOout, PCout, MDRout, Inportout, Cout;
reg HIen, LOen, PCen, MARen, IRen, MDRen, Read, Outporten, RAMwrite;
reg Graen, Graout, Grb, Grc, BAout;
reg clk, clr;
parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
reg [3:0] Present_state = Default;
reg[3:0] op;
datapath DUT(clk, clr, HIout, LOout, PCout, MDRout, Inportout, Cout, 
HIen, LOen, PCen, MARen, IRen, Outporten, RAMwrite,
op, MDRen, Read, Graen, Graout, Grb, Grc, BAout);
// add test logic here
initial
	begin
		clk = 0;
		forever #10 clk = ~ clk;
	end
always @(posedge clk) // finite state machine; if clock rising-edge
	begin
		case (Present_state)
			Default : Present_state = Reg_load1a;
			Reg_load1a : Present_state = Reg_load1b;
			Reg_load1b : Present_state = Reg_load2a;
			Reg_load2a : Present_state = Reg_load2b;
			Reg_load2b : Present_state = Reg_load3a;
			Reg_load3a : Present_state = Reg_load3b;
			Reg_load3b : Present_state = T0;
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
				Graout<= 0;Graen<= 0;Grb<= 0;Grc<= 0;BAout<= 0;
				op <= 4'b0000;
				clr<= 1;
				#10 clr <= 0;
			end
			Reg_load1a: begin
				
			end
			Reg_load1b: begin
			
			end
			Reg_load2a: begin
				
			end
			Reg_load2b: begin
				
				
			end
			Reg_load3a: begin
				
			end
			Reg_load3b: begin
				
			end
			T0: begin
				#10 PCout = 1; MARen = 1; 
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
				#10 Grb <= 1; BAout <= 1; Cout <=1; op <= 4'd4; MARen<=1;
				#10 Grb <= 0; BAout <= 0; Cout <=0; MARen <=0;
			end
			T4: begin
				#10 Read <= 1; MDRen <= 1;
				#10 Read <= 0; MDRen <= 0;
			end
			T5: begin
				#10 MDRout <= 1; Graen <= 1; op <= 4'd15;
				#10 MDRout <= 0; Graen <= 0;
			end
			T6: begin
			end
			T7: begin
			end
		endcase
	end
endmodule
