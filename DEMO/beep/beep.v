`timescale 1ns / 1ps

module beep(clk,rst,btn,beep_out);

input clk,rst,btn;
output beep_out;

reg beep_slow,beep_quick;

//时钟选择
assign beep_out = (btn==1'b0)?(beep_slow):(beep_quick);

//慢速时�
reg [28:0]cnt_slow;
reg xs;
always @(posedge clk or posedge rst) 
begin
	if (rst) begin beep_slow<=1; cnt_slow<=0; xs<=0; end
	else 
	begin
		if(!xs)
		begin
			if(cnt_slow==248000000)begin beep_slow<=0; cnt_slow<=0; xs<=~xs; end
			else cnt_slow<=cnt_slow+1;
		end
		else
		begin
			if(cnt_slow==2000000)begin beep_slow<=1; cnt_slow<=0; xs<=~xs; end
			else cnt_slow<=cnt_slow+1;
		end
	end
end
//快速时�
reg [28:0]cnt_quick;
reg xq;
always @(posedge clk or posedge rst) 
begin
	if (rst) begin beep_quick<=1; cnt_quick<=0; xq<=0; end
	else 
	begin
		if(!xq)
		begin
			if(cnt_quick==30000000)begin beep_quick<=0; cnt_quick<=0; xq<=~xq; end
			else cnt_quick<=cnt_quick+1;
		end
		else
		begin
			if(cnt_quick==30000000)begin beep_quick<=1; cnt_quick<=0; xq<=~xq; end
			else cnt_quick<=cnt_quick+1;
		end
	end
end
endmodule
