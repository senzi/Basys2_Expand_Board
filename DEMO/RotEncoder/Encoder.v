`timescale 1ns / 1ps

module Encoder(A,B,clk,reset,output8,lock,cs);
input clk,A,B,reset,lock,cs;
output[7:0]  output8;
reg[15:0] count;
reg[15:0] out_lock;
reg[7:0]  output_8;
reg A1,B1,A2,B2,cs1,cs2;
always@(posedge clk)
  begin 
   if (reset==0)
       count<=16'b0;
   else begin 
      A2<=A;
      A1<=A2;
      B2<=B;
      B1<=B2;
     if(( A2==1&&A1==0&&B==0)||(A2==0&&A1==1&&B==1)||
(B2==1&&B1==0&&A==1'b1)||(B2==0&&B1==1&&A==1'b0))
      count<=count+1;
     else if (( A2==1&&A1==0&&B==1)||(A2==0&&A1==1&&B==0)||
(B2==1&&B1==0&&A==0)||(B2==0&&B1==1&&A==1))
      count<=count-1;
      else 
      count<=count;
     end 
   end
 always@(posedge lock)
 begin
    if (reset==0)
   out_lock<=16'b0;
   else 
     out_lock<=count;
 end
 always@(posedge clk)
 begin 
  if (reset==0)
  output_8<=8'b0;
   else begin 
        cs2<=cs;
        cs1<=cs2;
    if (cs2==1&&cs1==0)
      output_8<=out_lock[15:8];
     else if (cs2==0&&cs1==1)
      output_8<=out_lock[7:0];
    end
 end
 assign output8=output_8;
endmodule

