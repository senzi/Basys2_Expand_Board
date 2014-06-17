`timescale 1ns / 1ps
module ds18b20(
  input        CLOCK_50,  //50M时钟信号                
  input        Q_KEY ,    //复位(上电复位/按键复位)
  inout        ds_inside, //内部传感器
  output [7:0] SEG7_SEG,  //七段数码管 段脚              
  output [3:0] SEG7_SEL  //七段数码管 待译位脚 
);

//++++++++++++++++++++++++++++++++++++++
// 获取温度值 开始
//++++++++++++++++++++++++++++++++++++++
wire [15:0] t_buf_inside;

ds18b20_drive ds18b20_inside(
  .clk(CLOCK_50),
  .rst(Q_KEY),
  //
  .one_wire(ds_inside),
  //
  .temperature(t_buf_inside)
);
//-------------------------------------
// 获取温度值 结束
//-------------------------------------

//+++++++++++++++++++++++++++++++++++++
// 数码管译码 开始
//+++++++++++++++++++++++++++++++++++++
wire [3:0] dp_in,turn_off_in;
assign dp_in = 4'b0010;
assign turn_off_in =4'b0000;

seg_drive seg7_u0(
  .i_clk            (CLOCK_50),
  .i_rst            (Q_KEY),

  .i_turn_off       (turn_off_in),
  .i_dp             (dp_in),
  .i_data           (t_buf_inside),
  .o_seg            (SEG7_SEG),
  .o_sel            (SEG7_SEL)
);
//-------------------------------------
// 数码管译码 结束
//-------------------------------------
endmodule