`timescale 1ns / 1ps

module top(i_clk,i_rst,trig,echo,o_seg,o_sel);

input i_clk,i_rst,echo;

output	trig;
output [7:0]  o_seg;
output [3:0]  o_sel;

wire [7:0] dis_value;
ultrasonic U0(
	.clk(i_clk),
	.rst(i_rst),
	.trig(trig),
	.echo(echo),
	.dis_value(dis_value));

wire [11:0]    DATA_OUT;
BCD U1(
	.clk(i_clk),
	.DATA_IN(dis_value),
	.DATA_OUT(DATA_OUT));

seg_drive U2(
   .i_clk(i_clk), 
   .i_rst(i_rst), 
   .i_turn_off(4'b0000),
   .i_dp(4'b0000), 
   .i_data(DATA_OUT), 
   .o_seg(o_seg), 
   .o_sel(o_sel));
endmodule
