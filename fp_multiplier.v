`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2017 12:47:45
// Design Name: 
// Module Name: fp_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fp_multiplier(in1,in2,clk,product);

input [31:0]in1;
input [31:0]in2;
input clk;
output [31:0]product;


reg [31:0]E1;
reg [31:0]E2;
reg sign=0;
reg round_val;
reg [8:0]exponent;
reg [22:0]mantissa;
reg [47:0]temp_product;

always@(posedge clk)
begin
	E1=in1;
	E2=in2;
	if(E1[30:0]==31'd0||E2[30:0]==31'd0)
	begin
			exponent=9'd0;
			mantissa=23'd0;
	end
	else
	begin
		sign=E1[31]^E2[31];
		exponent=E1[30-:8]+E2[30-:8]-8'd127;
		E1[31-:9]=9'd1;
		E2[31-:9]=9'd1;
		temp_product=E1*E2;
		if(temp_product[47])
		begin
			exponent=exponent+9'd1;
			round_val=temp_product[23];
			mantissa=temp_product[46-:23]+{22'd0 , round_val};
		end
		else
		begin
			round_val=temp_product[22];
			mantissa=temp_product[45-:23]+{22'd0 , round_val};
		end
		exponent[8]=sign;
	end
end
	
assign product={sign,exponent,mantissa};

endmodule

