`timescale 1 ns / 1 ns


module top(i_clk, i_rst, start, select0, i_turn_off, o_sel0, o_seg0, led);
   input        i_clk;
   input        i_rst;
   input        start;
   input        select0;
   input [3:0]  i_turn_off;
   output [3:0] o_sel0;
   output [7:0] o_seg0;
   output [2:0] led;
   
   
   wire         o_select_xd;
   wire         o_start_xd;
   wire [3:0]   o_sel;
   wire [7:0]   o_seg;
   wire [23:0]  i_control_data;
   wire [15:0]  o_control_data;
   
   
   seg_drive u1(.i_clk(i_clk), .i_rst(i_rst), .i_turn_off(i_turn_off), .i_data(o_control_data), .o_seg(o_seg0), .o_sel(o_sel0));
   
   timer u2(.clk(i_clk), .reset(i_rst), .start(o_start_xd), .data_out(i_control_data));
   
   btn_xd the_select(.i_clk(i_clk), .i_btn(select0), .o_btn(o_select_xd));
   
   btn_xd the_start(.i_clk(i_clk), .i_btn(start), .o_btn(o_start_xd));
   
   data_control u4(.i_btn(o_select_xd), .i_clk(i_clk), .i_data(i_control_data), .o_data(o_control_data), .o_led(led));
   
endmodule
