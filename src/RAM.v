module RAM ( input[31:0] Data, input[8:0] Address, input read, write, clk, 
output reg [31:0] Mdatain 
);

reg [31:0]mem[511:0];
initial begin
$readmemh("mem_init.hex",mem);
end
always @(*) begin
	if(read) Mdatain = mem[Address];
	else if(write) mem[Address] = Data;
end	

endmodule
