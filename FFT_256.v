`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2018 10:24:58 AM
// Design Name: 
// Module Name: FFT_256
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


module FFT_256(clk,in);
    input [63:0]in;
    input clk;
    reg clk_en,reset;
    reg outr;
    reg in_last,in_valid;
    reg config_valid;
    wire [15:0]configdata;
    xfft_0 your_instance_name (
        .aclk(clk),                                                // input wire aclk
        .aclken(clk_en),                                            // input wire aclken
        .aresetn(reset),                                          // input wire aresetn
        .s_axis_config_tdata(configdata),                  // input wire [15 : 0] s_axis_config_tdata
        .s_axis_config_tvalid(config_valid),                // input wire s_axis_config_tvalid
        .s_axis_config_tready(s_axis_config_tready),                // output wire s_axis_config_tready
        .s_axis_data_tdata(in),                      // input wire [63 : 0] s_axis_data_tdata
        .s_axis_data_tvalid(in_valid),                    // input wire s_axis_data_tvalid
        .s_axis_data_tready(s_axis_data_tready),                    // output wire s_axis_data_tready
        .s_axis_data_tlast(in_last),                      // input wire s_axis_data_tlast
        .m_axis_data_tdata(m_axis_data_tdata),                      // output wire [63 : 0] m_axis_data_tdata
        .m_axis_data_tvalid(m_axis_data_tvalid),                    // output wire m_axis_data_tvalid
        .m_axis_data_tready(outr),                    // input wire m_axis_data_tready
        .m_axis_data_tlast(m_axis_data_tlast),                      // output wire m_axis_data_tlast
        .event_frame_started(event_frame_started),                  // output wire event_frame_started
        .event_tlast_unexpected(event_tlast_unexpected),            // output wire event_tlast_unexpected
        .event_tlast_missing(event_tlast_missing),                  // output wire event_tlast_missing
        .event_status_channel_halt(event_status_channel_halt),      // output wire event_status_channel_halt
        .event_data_in_channel_halt(event_data_in_channel_halt),    // output wire event_data_in_channel_halt
        .event_data_out_channel_halt(event_data_out_channel_halt)  // output wire event_data_out_channel_halt
);
endmodule
