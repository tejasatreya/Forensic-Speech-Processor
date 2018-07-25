`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2017 12:42:04
// Design Name: 
// Module Name: hamming
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


module hamming(
    input [31:0] in,
    output [31:0] out,
    input clk,
    input en
    );
    
    wire [7:0] addr;
    wire [31:0] dout;
    
    Counter C0 (
      .CLK(clk),  // input wire CLK
      .CE(en),    // input wire CE
      .Q(addr)      // output wire [7 : 0] Q
    );
   blk_mem_gen_0 BRAM0 (
      .clka(clk),    // input wire clka
      .ena(1'b1),      // input wire ena
      .wea(1'b0),      // input wire [0 : 0] wea
      .addra(addr),  // input wire [7 : 0] addra
      .dina(32'b0),    // input wire [31 : 0] dina
      .douta(dout)  // output wire [31 : 0] douta
    );
    
    fp_multiplier FM0 (in,dout,clk,out);
    
    
endmodule
