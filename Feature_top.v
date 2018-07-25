`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2018 10:25:58 AM
// Design Name: 
// Module Name: Feature_top
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


module Feature_top(clk,in_1);
    input [31:0]in_1;
    input clk;
    reg en_ham;
    wire [31:0]out_ham;
    hamming H0(in_1,out_ham,clk,en_ham);
    FFT_256 FFT0(clk);
    Melfilter_log MEL0();
    DCT DCT0();
endmodule
