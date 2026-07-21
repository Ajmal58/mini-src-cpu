module controlUnit(output reg Graen, Graout, Grb, Grc, 
HIout, LOout, PCout, MDRout, Inportout, Cout, 
HIen, LOen, PCen, MARen, IRen, Outporten, RAMwrite, MDRen, Read, BAout, CON, reten, run,
output reg [4:0] op,
input clk, clr, stop, 
input [31:27]IR);
	
	parameter T0 = 4'b0000,T1 = 4'b0001, T2 = 4'b0010, T3 = 4'b0011, T4 = 4'b0100, T5 = 4'b0101, T6 = 4'b0110, halt = 4'b0111;
	
	reg S0, S1, S2, S3, S4, S5, Shalt;
	reg ld_s, ldi_s, st_s,add_s,sub_s ,shr_s ,shra_s,shl_s,ror_s,rol_s,and_s,or_s,addi_s,andi_s,ori_s,mul_s,div_s,neg_s,not_s,br_s,jr_s,jal_s,in_s,out_s,mfhi_s,mflo_s,nop_s,halt_s;
	reg [3:0]Present_state = T0;
	always @(posedge clk)
	begin
		if(clr) Present_state = T0;
		else if (stop||halt_s) begin
			Shalt <=1;
			Present_state = halt;
		end
		else begin
			S0 <=0; S1 <=0; S2 <=0; S3 <=0; S4 <=0; S5 <=0; Shalt <=0;
			case (Present_state)
				T0 : begin
					S0<=1;
					Present_state = T1;
				end
				T1 : begin
					S1<=1;
					Present_state = T2;
				end
				T2 : begin
					S2<=1;
					Present_state = T3;
				end
				T3 :begin
					S3<=1;
					Present_state = T4;
				end
				T4 : begin
					S4<=1;
					Present_state = T5;
				end
				T5 : begin
					S5 <=1;
					Present_state = T0;
				end
			endcase
		end
	end
	
	
	always @(IR)	begin
		ld_s<=0; ldi_s<=0; st_s<=0; add_s <= 0; sub_s <= 0;shr_s <= 0;shra_s<= 0;shl_s<= 0;ror_s<= 0;rol_s<= 0;and_s<= 0;or_s<= 0;addi_s<= 0;andi_s<= 0;ori_s<= 0;mul_s<= 0;div_s<= 0;neg_s<= 0;not_s<= 0;br_s<= 0;jr_s<= 0;jal_s<= 0;in_s<= 0;out_s<= 0;mfhi_s<= 0;mflo_s<= 0;nop_s<= 0;halt_s<= 0;
		case (IR[31:27]) 	
			5'b00000: ld_s<=1;
			5'b00001:ldi_s<=1;	
			5'b00010:st_s<=1;
			5'b00011:add_s<=1;
			5'b00100:sub_s<=1;
			5'b00101:shr_s<=1;
			5'b00110:shra_s<=1;
			5'b00111:shl_s<=1;
			5'b01000:ror_s<=1;
			5'b01001:rol_s<=1;
			5'b01010:and_s<=1;
			5'b01011:or_s<=1;
			5'b01100:addi_s<=1;
			5'b01101:andi_s<=1;
			5'b01110:ori_s<=1;
			5'b01111:mul_s<=1;
			5'b10000:div_s<=1;
			5'b10001:neg_s<=1;
			5'b10010:not_s<=1;
			5'b10011:br_s<=1;
			5'b10100:jr_s<=1;
			5'b10101:jal_s<=1;
			5'b10110:in_s<=1;
			5'b10111:out_s<=1;
			5'b11000:mfhi_s<=1;
			5'b11001:mflo_s<=1;
			5'b11010:nop_s<=1;
			5'b11011:halt_s<=1;
		endcase
	end

	always @(clk, S0, S1, S2, S3, S4, S5, halt) begin
		Graen <= ((ld_s||add_s||sub_s||shr_s||shra_s||shl_s||ror_s||rol_s||and_s||or_s||addi_s||andi_s||ori_s||neg_s||not_s||in_s||mfhi_s||mflo_s)&&S5)||(ldi_s&&S3);
		Graout <= ((st_s||jal_s||jr_s)&&S4)||((mul_s||div_s||br_s)&&S3);
		Grb <= (ld_s||ldi_s||st_s||add_s||sub_s||shr_s||shra_s||shl_s||ror_s||rol_s||and_s||or_s||addi_s||andi_s||ori_s||mul_s||div_s||neg_s||not_s)&&S3;
		Grc <= (add_s||sub_s||shr_s||shra_s||shl_s||ror_s||rol_s||and_s||or_s)&&S3;
		HIout <= mfhi_s&&S3;
		LOout <= mflo_s&&S3 ;
		PCout <= S0||S1||(jal_s&&S3)||(br_s&&S4);
		MDRout <= S2||(ld_s&&S5);
		Inportout <= in_s&&S3;
		Cout <= ((ld_s||ldi_s||st_s||addi_s||andi_s||ori_s)&&S3)||(br_s&&S4);
		HIen <=  (mul_s||div_s)&&S3;
		LOen <=  (mul_s||div_s)&&S3;
		PCen <=  S1||((jr_s||jal_s)&&S4);
		MARen <= S0||((ld_s||st_s)&&S3);
		IRen <= S2;
		Outporten <= out_s&&S3;
		RAMwrite <= st_s&&S5;
		MDRen <= S1||((ld_s||st_s)&&S4);
		Read <= S1||(ld_s&&S4);
		BAout <= (ld_s||ldi_s||st_s)&&S3;
		CON <= br_s&&S4;
		reten <= jal_s&&S3;
		run <= !Shalt;
		
		if (S1) op <= 5'd13;
		else if (((mflo_s||mfhi_s||jal_s||in_s)&&S3)||S2||S0||(ld_s&&S5)) op <= 5'd14;
		else if (((st_s||jr_s||jal_s)&&S4)||(br_s&&S3)) op <= 5'd15;
		else if ((andi_s||and_s)&&S3) op <= 5'd0; 
		else if ((or_s||ori_s)&&S3) op <= 5'd1; 
		else if (neg_s&&S3) op <= 5'd2; 
		else if (not_s&&S3) op <= 5'd3; 
		else if (((add_s||addi_s||ld_s||ldi_s||st_s)&&S3)||(br_s&&S4)) op <= 5'd4;
		else if (sub_s&&S3) op <= 5'd5; 
		else if (mul_s&&S3) op <= 5'd6;
		else if (div_s&&S3) op <= 5'd7;
		else if (shr_s&&S3) op <= 5'd8;
		else if (shra_s&&S3) op <= 5'd9; 
		else if (shl_s&&S3) op <= 5'd10;
		else if (ror_s&&S3) op <= 5'd11;
		else if (rol_s&S3) op <= 5'd12;
		 		
		
		
	end

	
	

endmodule
