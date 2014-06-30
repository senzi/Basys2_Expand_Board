`timescale 1ns / 1ps

module Encoder(A,B,clk,reset,output8);
input clk,A,B,reset;
output[7:0]  output8;
reg[9:0] count;
reg A1,B1,A2,B2;
reg [15:0] cnt;

always @(posedge clk) begin cnt <= cnt + 1; end 

always@(posedge clk)
begin
	if(reset==0) count=0;
	else begin
		A2<=A;
	    A1<=A2;
	    B2<=B;
	    B1<=B2;
	    if(( A2==1&&A1==0&&B==0)||(A2==0&&A1==1&&B==1)||(B2==1&&B1==0&&A==1)||(B2==0&&B1==1&&A==0))
	    	count<=count + 1;
		else if (( A2==1&&A1==0&&B==1)||(A2==0&&A1==1&&B==0)||(B2==1&&B1==0&&A==0)||(B2==0&&B1==1&&A==1))
			count<=count - 1;
	end    
end

assign output8=count>>2;
endmodule

