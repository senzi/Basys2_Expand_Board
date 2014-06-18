`timescale 1 ns / 1 ns


module data_control(i_data, o_data, o_led);
   input [23:0]  i_data;
   output [15:0] o_data;
   reg [15:0]    o_data;
   output [2:0]  o_led;

   always @(*)
      begin
         o_data[15:12] <= i_data[15:12];
         o_data[11:8] <= i_data[11:8];
         o_data[7:4] <= i_data[7:4];
         o_data[3:0] <= i_data[3:0];
      end
   
   assign o_led[2:0] = ((3'b010) & {i_data[4], i_data[4], i_data[4]}) | {i_data[7], i_data[7], i_data[7]};
   
endmodule
