module tlc_549(CLOCK_50,RST_N,ADC549_DATA,ADC549_CLK,ADC549_CS_N,SEG7_SEG,SEG7_SEL);

    input         CLOCK_50; 
    input         RST_N;

    input         ADC549_DATA;
    output        ADC549_CLK;
    output        ADC549_CS_N;

    output [7 :0] SEG7_SEG;       
    output [3 :0] SEG7_SEL;  
 
    wire   [7 :0] ad_data;
    wire   [15:0] segdata;
    wire   [11:0] wire_bcd;

    assign segdata = {4'b0000,wire_bcd};


tlc549_drive U0(
    .clk              (CLOCK_50),
    .reset            (1'b1),
    .dateout          (ad_data),
    .cs               (ADC549_CS_N),
    .clk_ad           (ADC549_CLK),
    .sdate            (ADC549_DATA));

BCD U1(
    .clk              (CLOCK_50),
    .DATA_IN          (ad_data),
    .DATA_OUT         (wire_bcd));
 
seg_drive U2(
    .i_clk            (CLOCK_50),
    .i_rst            (RST_N),
   
    .i_turn_off       (4'b0000), 
    .i_dp             (4'b0000), 
    .i_data           (segdata), 
   
    .o_seg            (SEG7_SEG),
    .o_sel            (SEG7_SEL));
 
endmodule