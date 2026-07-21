`timescale 1ns/10ps
module TESTBENCH();
reg clk, clr;
reg r0out, r1out, r2out, r3out, r4out, r5out, r6out, r7out, r8out, r9out, r10out, r11out, r12out, r13out, r14out, r15out, MDRout, ZLOout;
reg r0en, r1en, r2en, r3en, r4en, r5en, r6en, r7en, r8en, r9en, r10en, r11en, r12en, r13en, r14en, r15en, ZHIen, ZLOen, Yen;
reg MDRen, MDRRead;
reg [31:0] r0in, r1in, r2in, mData;

reg [3:0] present_state, op;

datapath DP( 
	clk, clr, 
	r0in, r1in, r2in, mData,
	r0out, r1out, r2out, r3out, r4out, r5out, r6out, r7out, r8out, r9out, r10out, r11out, r12out, r13out, r14out, r15out, MDRout, ZLOout,
	r0en, r1en, r2en, r3en, r4en, r5en, r6en, r7en, r8en, r9en, r10en, r11en, r12en, r13en, r14en, r15en, ZHIen, ZLOen,
	Yen, op,
	MDRen, MDRRead
);



parameter init = 4'd1, TO = 4'd2, T1 = 4'd3, T2 = 4'd4, T3 = 4'd5; 

initial begin clk = 0; present_state = 4'd0; end
always #10 clk = ~clk;
always @(negedge clk) present_state = present_state + 1;

always @(present_state) begin 
	case(present_state)
		init: begin
			clr <= 1;
			r0in <= 32'b0; r1in <= 32'b0; r2in <= 32'b0;
			r0out <= 0; r1out <= 0; r2out <= 0; r0en <= 0; r1en <= 0; r2en <= 0; MDRen <=0; MDRRead <= 0; mData <= 0;
			#15 clr <= 0;
		end
		TO: begin
			r1in <= 32'd15; r1en <= 1; r1out <= 1; Yen <= 1;
			#15  r1en <= 0; r1out <= 0; Yen <= 0;
		end
		T1: begin
			r2in <= 32'd17; r2en <=1; r2out <= 1; op <= 4'd4; ZLOen <= 1;
			#15 r2en <= 0; r2out <= 0; ZLOen <= 0;
		end 
		T2: begin
			ZLOout<= 1; 
			#15 ZLOout <= 0;
	
		end
		T3: begin
			
	
		end
	endcase
end
endmodule
