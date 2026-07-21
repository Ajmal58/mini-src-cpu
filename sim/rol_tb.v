`timescale 1ns/10ps
module rol_tb;

reg r0out, r1out, r2out, r3out, r4out, r5out, r6out, r7out, r8out, r9out, r10out, r11out, r12out, r13out, r14out, r15out,  HIout, LOout, ZHIout, ZLOout, PCout, MDRout, Inportout, Cout;
reg r0en, r1en, r2en, r3en, r4en, r5en, r6en, r7en, r8en, r9en, r10en, r11en, r12en, r13en, r14en, r15en, HIen, LOen, ZHIen, ZLOen, PCen, 
Yen, MARen, IRen, MDRen, Read;
reg clk, clr;
reg [31:0] Mdatain;
parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
reg [3:0] Present_state = Default;
reg[3:0] op;
datapath DUT(clk, clr, Mdatain,
r0out, r1out, r2out, r3out, r4out, r5out, r6out, r7out, r8out, r9out, r10out, r11out, r12out, r13out, r14out, r15out,  HIout, LOout, ZHIout, ZLOout, PCout, MDRout, Inportout, Cout,
r0en, r1en, r2en, r3en, r4en, r5en, r6en, r7en, r8en, r9en, r10en, r11en, r12en, r13en, r14en, r15en, HIen, LOen, ZHIen, ZLOen, PCen, 
Yen, MARen, IRen,
op,
MDRen, Read);
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
				r0out <= 0; r1out<= 0; r2out<= 0; r3out<= 0; r4out<= 0; r5out<= 0; r6out<= 0; r7out<= 0; r8out<= 0; r9out<= 0; r10out<= 0; r11out<= 0; r12out<= 0; r13out<= 0; r14out<= 0; r15out<= 0;  ZHIout<= 0; ZLOout<= 0; PCout<= 0; MDRout<= 0; Inportout<= 0; Cout<= 0;
				r0en<= 0; r1en<= 0; r2en<= 0; r3en<= 0; r4en<= 0; r5en<= 0; r6en<= 0; r7en<= 0; r8en<= 0; r9en<= 0; r10en<= 0; r11en<= 0; r12en<= 0; r13en<= 0; r14en<= 0; r15en<= 0; HIen <= 0; LOen <=0; ZHIen<= 0; ZLOen<= 0; PCen<= 0; 
				Yen<= 0; MARen<= 0; IRen<= 0;
				op<= 0;
				MDRen<= 0; Read<= 0;
			end
			Reg_load1a: begin
				Mdatain <= 32'hFFFFFFF4;
				#10 Read <= 1; MDRen <= 1;
				#10 Read <= 0; MDRen <= 0;
			end
			Reg_load1b: begin
				#10 MDRout <= 1; r2en <= 1;	
				#10 MDRout <= 0; r2en <= 0; // initialize R2 with the value $2
			end
			Reg_load2a: begin
				Mdatain <= 2;
				#10 Read <= 1; MDRen <= 1;
				#10 Read <= 0; MDRen <= 0;
			end
			Reg_load2b: begin
				#10 MDRout <= 1; r3en <= 1;
				#10 MDRout <= 0; r3en <= 0; // initialize R3 with the value $4
			end
			Reg_load3a: begin
				Mdatain <= 32'h00000018;
				#10 Read <= 1; MDRen <= 1;
				#10 Read <= 0; MDRen <= 0;
			end
			Reg_load3b: begin
				#10 MDRout <= 1; r1en <= 1;
				#10 MDRout <= 0; r1en <= 0; // initialize R1 with the value $18
			end
			T0: begin
				#10 PCout <= 1; MARen <= 1; op <= 14; ZLOen <= 1;
				#10 PCout <= 0; MARen <= 0; ZLOen <= 0;
			end
			T1: begin
				Mdatain <= 32'h28918000;
				#10 ZLOout <= 1; PCen <= 1; Read <= 1; MDRen <= 1;
				#10 ZLOout <= 0; PCen <= 0; Read <= 0; MDRen <= 0;
			end
			T2: begin
				#10 MDRout <= 1; IRen <= 1;
				#10 MDRout <= 0; IRen <= 0;
			end
			T3: begin
				#10 r2out <= 1; Yen <= 1;
				#10 r2out <= 0; Yen <= 0;
			end
			T4: begin
				#10 r3out <= 1; op <= 13; ZLOen <= 1;
				#10 r3out <= 0; ZLOen <= 0;
			end
			T5: begin
				#10 ZLOout <= 1; r1en <= 1;
				#10 ZLOout <= 0; r1en <= 0;
			end
		endcase
	end
endmodule
