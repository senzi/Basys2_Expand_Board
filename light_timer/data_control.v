`timescale 1 ns / 1 ns


module data_control(i_btn, i_clk, i_data, o_data, o_led);
   input         i_btn;
   input         i_clk;
   input [23:0]  i_data;
   output [15:0] o_data;
   reg [15:0]    o_data;
   output [2:0]  o_led;
   
   reg [2:0]     stage;
   
   
   always @(posedge i_clk)
      
      begin
         if (i_btn == 1'b1)
            case (stage)
               3'b001 :
                  stage <= 3'b010;
               3'b010 :
                  stage <= 3'b100;
               3'b100 :
                  stage <= 3'b001;
               default :
                  stage <= 3'b001;
            endcase
      end
   
   
   always @(posedge i_clk)
      
         case (stage)
            3'b010 :
               begin
                  o_data[15:12] <= i_data[23:20];
                  o_data[11:8] <= i_data[19:16];
                  o_data[7:4] <= i_data[15:12];
                  o_data[3:0] <= i_data[11:8];
               end
            3'b100 :
               begin
                  o_data[15:12] <= 4'b1111;
                  o_data[11:8] <= 4'b1111;
                  o_data[7:4] <= i_data[23:20];
                  o_data[3:0] <= i_data[19:16];
               end
            3'b001 :
               begin
                  o_data[15:12] <= i_data[15:12];
                  o_data[11:8] <= i_data[11:8];
                  o_data[7:4] <= i_data[7:4];
                  o_data[3:0] <= i_data[3:0];
               end
            default :
               o_data <= {16{1'b0}};
         endcase
   
   assign o_led[2:0] = ((stage) & {i_data[4], i_data[4], i_data[4]}) | {i_data[7], i_data[7], i_data[7]};
   
endmodule
