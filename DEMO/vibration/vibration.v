`timescale 1ns / 1ps

module vibration(clk,rst,control,led,vibration);
input        vibration;
input        clk,rst;  
input  [7:0] control;  //拨码开�

output [7:0] led;      //水银开�
reg    [7:0] led;

reg    [25:0]cnt_quick;
reg          cnt_control;

wire         clk_choice;
reg          clk_quick;

//时钟选择
assign clk_choice = (control==0)?(vibration):(clk_quick);



//quick
always @(posedge clk or posedge rst) 
begin
 	if (rst) begin cnt_quick<=0;clk_quick<=0; end
 	else if (cnt_quick==2375000)begin cnt_quick<=0; clk_quick<=(~clk_quick); end
 	else cnt_quick<=cnt_quick+1;
 end

//count the control 
always @(posedge clk or posedge rst) 
begin
	if (rst) begin cnt_control<=0; end
	else case (control)
			8'b00000000:cnt_control<=1;
			8'b00000001:cnt_control<=1;
			8'b00000010:cnt_control<=1;
			8'b00000100:cnt_control<=1;
			8'b00001000:cnt_control<=1;
			8'b00010000:cnt_control<=1;
			8'b00100000:cnt_control<=1;
			8'b01000000:cnt_control<=1;
			8'b10000000:cnt_control<=1;
			default    :cnt_control<=0;
			endcase 		
end

reg x; //闪动
always @(posedge clk_choice or posedge rst) 
begin
	if (rst) begin led<=8'b10000000; x<=0; end
	else 
	begin 
		if((led==8'b00000001)&&(!control==led))      led<=8'b10000000;
		else if((led==8'b00000000)&&(cnt_control==1))led<=8'b10000000;
		else if((control==led)&&(cnt_control==1))    led<=control;
		else if(cnt_control==0)					
			begin
				if(x==1)begin led<=control; x<=~x; end
				else led<=0; x<=~x;
			end
		else led<=(led>>1);	
	end
end
endmodule
