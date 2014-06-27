`timescale 1 ns / 1 ns


module vibrate(i_clk,i_rst,up,o_sel,o_seg,sw);
   input        i_clk,i_rst,up,sw;
   output [3:0] o_sel;
   output [7:0] o_seg;

wire o_up,vibration_in; 
wire [15:0] display;
assign vibration_in = (sw)?(o_up):(up);
btn_xd up_vibrate(
   .i_clk(i_clk), 
   .i_btn(up), 
   .o_btn(o_up));

vibration vibration(
   .rst(i_rst),
   .up(vibration_in),
   .count_out(display));

seg_drive seg_drive(
   .i_clk(i_clk), 
   .i_rst(i_rst), 
   .i_turn_off(4'b0000),
   .i_dp(4'b0000), 
   .i_data(display), 
   .o_seg(o_seg), 
   .o_sel(o_sel));

/*btn_xd down_vibrate(
   .i_clk(i_clk), 
   .i_btn(), 
   .o_btn());
*/ 
   
endmodule




