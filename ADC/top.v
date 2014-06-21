module tlc_549_test(
  input  CLOCK_50, // 板载50MHz时钟 
  input  RST_N,
  //
  output ADC549_CLK,
  output ADC549_CS_N,
  input ADC549_DATA,
  //
  output [7:0] SEG7_SEG, // 七段数码管 段脚              
  output [3:0] SEG7_SEL  // 七段数码管 位脚 
);
 
wire [7:0] ad_data;
wire [15:0] data_dis;
assign data_dis = {2'b00,ad_data[7:6],2'b00,ad_data[5:4],2'b00,ad_data[3:2],2'b00,ad_data[1:0]};

tlc549_driver tlc549_driver_inst(
    .clk(CLOCK_50),
    .reset(1'b1),
    //
    .dateout(ad_data),
    // 
    .cs(ADC549_CS_N),
    .clk_ad(ADC549_CLK),
    .sdate(ADC549_DATA)
);
 
seg7x8_drive u0(
  .i_clk            (CLOCK_50),
  .i_rst          (RST_N),
   
  .i_turn_off       (4'b0000), // 熄灭位[2进制]
  .i_dp             (4'b0000), // 小数点位[2进制]
  .i_data           (data_dis), // 欲显数据[16进制]
   
  .o_seg            (SEG7_SEG),
  .o_sel            (SEG7_SEL)
);
 
endmodule