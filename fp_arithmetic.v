`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:56:40 12/23/2017 
// Design Name: 
// Module Name:    fp_arithmetic 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fp_arithmetic(in1,in2,operation,en,sum,ackn);

input [31:0]in1;
input [31:0]in2;
input operation;
input en;
output [31:0]sum;
output reg ackn;

reg [7:0]exponent;
reg [31:0]E1;
reg [31:0]E2;
reg [22:0]mantissa;
reg [54:0]temp;
reg sign=1'b0;
reg subtract=1'b0;
reg round_val=1'b0;
reg [7:0]shift_bits=0;

always@(en)
begin

	

	if(in1[30:0]==31'd0)
	begin
		sign=in2[31]^operation;
		exponent=in2[30:23];
		mantissa=in2[22:0];
	end
	else if(in2[30:0]==31'd0)
	begin
		sign=in1[31];
		exponent=in1[30:23];
		mantissa=in1[22:0];
	end
	else
	begin
		E2=in2;
		E2[31]=E2[31]^operation;
		if(in1[30-:8]<in2[30-:8])
		begin
			E1=E2;
			E2=in1;
		end
		else
			E1=in1;
		sign=E1[31];
		exponent=E1[30-:8];
		shift_bits=E1[30-:8]-E2[30-:8];
		subtract=E1[31]^E2[31];
		if(shift_bits)
			round_val=E2[shift_bits-1];
		E1[31-:9]=9'd1;
		E2[31-:9]=9'd1;
		E2=E2>>shift_bits;
		E2=E2+round_val;
		if(subtract)
			if(E1>E2)
				temp={E1 , E1[22:0]}-{E2 , E2[22:0]};
			else
			begin
				temp={E2 , E2[22:0]}-{E1 , E1[22:0]};
				sign=!sign;
			end
		else
			temp={E2 , E2[22:0]}+{E1 , E1[22:0]};
		if(temp[47]==1'b1)
		begin
			round_val=temp[23];
			exponent=exponent+8'd1;
			mantissa=temp[46-:23]+{22'd0 , round_val};
		end
		else
		begin
			casex(temp)
			55'b000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				round_val=temp[22];
				mantissa=temp[45-:23]+{22'd0,round_val};
			end
			55'b0000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd1;
				round_val=temp[21];
				mantissa=temp[44-:23]+{22'd0,round_val};
			end
			55'b00000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd2;
				round_val=temp[20];
				mantissa=temp[43-:23]+{22'd0,round_val};
			end
			55'b000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd3;
				round_val=temp[19];
				mantissa=temp[42-:23]+{22'd0,round_val};
			end
			55'b0000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd4;
				round_val=temp[18];
				mantissa=temp[41-:23]+{22'd0,round_val};
			end
			55'b00000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd5;
				round_val=temp[17];
				mantissa=temp[40-:23]+{22'd0,round_val};
			end
			55'b000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd6;
				round_val=temp[16];
				mantissa=temp[39-:23]+{22'd0,round_val};
			end
			55'b0000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd7;
				round_val=temp[15];
				mantissa=temp[38-:23]+{22'd0,round_val};
			end
			55'b00000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd8;
				round_val=temp[14];
				mantissa=temp[37-:23]+{22'd0,round_val};
			end
			55'b000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd9;
				round_val=temp[13];
				mantissa=temp[36-:23]+{22'd0,round_val};
			end
			55'b0000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd10;
				round_val=temp[12];
				mantissa=temp[35-:23]+{22'd0,round_val};
			end
			55'b00000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd11;
				round_val=temp[11];
				mantissa=temp[34-:23]+{22'd0,round_val};
			end
			55'b000000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd12;
				round_val=temp[10];
				mantissa=temp[33-:23]+{22'd0,round_val};
			end
			55'b0000000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd13;
				round_val=temp[9];
				mantissa=temp[32-:23]+{22'd0,round_val};
			end
			55'b00000000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd14;
				round_val=temp[8];
				mantissa=temp[31-:23]+{22'd0,round_val};
			end
			55'b000000000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd15;
				round_val=temp[7];
				mantissa=temp[30-:23]+{22'd0,round_val};
			end
			55'b0000000000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd16;
				round_val=temp[6];
				mantissa=temp[29-:23]+{22'd0,round_val};
			end
			55'b00000000000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd17;
				round_val=temp[5];
				mantissa=temp[28-:23]+{22'd0,round_val};
			end
			55'b000000000000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd18;
				round_val=temp[4];
				mantissa=temp[27-:23]+{22'd0,round_val};
			end
			55'b0000000000000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd19;
				round_val=temp[3];
				mantissa=temp[26-:23]+{22'd0,round_val};
			end
			55'b00000000000000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd20;
				round_val=temp[2];
				mantissa=temp[25-:23]+{22'd0,round_val};
			end
			55'b000000000000000000000000000001xxxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd21;
				round_val=temp[1];
				mantissa=temp[24-:23]+{22'd0,round_val};
			end
			55'b0000000000000000000000000000001xxxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd22;
				round_val=temp[0];
				mantissa=temp[23-:23]+{22'd0,round_val};
			end
			55'b00000000000000000000000000000001xxxxxxxxxxxxxxxxxxxxxxx :
			begin
				exponent=exponent-8'd23;
				mantissa=temp[22-:23];
			end
			endcase
		end
	end
	ackn=1'b1;
	
	
//added code begins
	if(operation==1 && in1==in2)
	
	begin
	 sign=1'b0;
	 exponent=8'b0;
	 mantissa=23'b0;
	end
		
//added code ends
	
end
assign sum={sign,exponent,mantissa};

endmodule

