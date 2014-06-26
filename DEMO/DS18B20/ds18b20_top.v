`timescale 1ns / 1ps
module ds18b20(
  input        CLOCK_50,  //50Mʱ���ź�                
  input        Q_KEY ,    //��λ(�ϵ縴λ/������λ)
  inout        ds_inside, //�ڲ�������
  output [7:0] SEG7_SEG,  //�߶������ �ν�              
  output [3:0] SEG7_SEL  //�߶������ ����λ�� 
);

//++++++++++++++++++++++++++++++++++++++
// ��ȡ�¶�ֵ ��ʼ
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
// ��ȡ�¶�ֵ ����
//-------------------------------------

//+++++++++++++++++++++++++++++++++++++
// ��������� ��ʼ
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
// ��������� ����
//-------------------------------------
endmodule