`timescale 1ns/10ps
module CONFF(input clk, input[31:0] BusData, input [3:0] IR, output out);

wire [31:0] val;
reg tclk;
initial tclk <= 1;
always @ (negedge clk) begin
	#1 tclk <= ~tclk;
end
reg32 r(clr, tclk, 1, BusData, val);

wire [1:0] c2 = IR[1:0];

assign out = ((c2 == 2'b00) && (val == 32'd0)) || ((c2 == 2'b01) && (val != 32'd0)) || ((c2 == 2'b10) && (val[31] == 0)) ||((c2 == 2'b11) && (val[31] == 1));

endmodule
