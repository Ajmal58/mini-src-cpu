`timescale 1ns/10ps
module datapath_tb;

reg ZHIout, ZLOout, PCout, MDRout, Inportout, Cout;
reg HIen, LOen, ZHIen, ZLOen, PCen, Yen, MARen, IRen, MDRen, Read, Outporten, RAMread, RAMwrite;
reg Gra, Grb, Grc, CRen, CRout, BAout;
reg clk, clr;
parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
reg [3:0] Present_state = Default;
reg[3:0] op;
datapath DUT(clk, clr, ZHIout, ZLOout, PCout, MDRout, Inportout, Cout, 
HIen, LOen, ZHIen, ZLOen, PCen, Yen, MARen, IRen, Outporten, RAMread, RAMwrite,
op, MDRen, Read, Gra, Grb, Grc, CRen, CRout, BAout);
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
			
		endcase
	end

always @(Present_state) // do the required job in each state
	begin
		case (Present_state) // assert the required signals in each clock cycle
			Default: begin	
				
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
				
			end
			T1: begin
				
			end
			T2: begin
				
			end
			T3: begin
				
			end
			T4: begin
				
			end
			T5: begin
				
			end
		endcase
	end
endmodule
