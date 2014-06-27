module ultrasonic(clk,rst,trig,echo,dis_value);//³¬Éù²¨
	input	clk;//50M
	input	rst;//rst when high
	input	echo;
	output	trig;
	
	output[7:0]	dis_value;
	
	/*************/
	//reg[7:0]	dis_value;
	reg [7:0]dis_value;
	reg	echo_r;
	/************/
	reg[11:0]	clk80us_count;
	wire		clk80us;
	always @(posedge clk or  posedge rst) begin
		if(rst) begin 
			clk80us_count <= 12'd0;
			echo_r <= 1'b0;
			end
		else	begin 
			clk80us_count <= clk80us_count + 1'd1;
			echo_r <= echo;
			end
		end
		
	assign	clk80us = clk80us_count[11];
	/********/
	reg[22:0]	clk160ms_cnt;
	wire		clk160ms;
	always @(posedge clk or posedge rst) begin
		if(rst) clk160ms_cnt <= 23'd0;
		else	clk160ms_cnt <= clk160ms_cnt + 1'd1;
		end
	assign clk160ms = clk160ms_cnt[22];
	assign trig		= clk160ms;//posedge and negedge trig ,80ms at most
	/*************/
	reg[7:0]	dis_cnt;
	always @(posedge clk80us or posedge rst) begin
		if(rst)	dis_cnt <= 8'd0;
		else begin
			if(echo) dis_cnt 	<= dis_cnt + 1'd1;//one count is present 2.7cm,if the distance >50ms(1.7m):dis_cnt=63 is over;
			else begin
				dis_cnt <= 8'd0;
				end
			end
		end
		
	always @(negedge echo_r or posedge rst) begin
		if(rst) dis_value	<= 8'd0;
		else dis_value	<= dis_cnt;
		end
endmodule 