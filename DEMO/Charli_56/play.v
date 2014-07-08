`timescale 1ns / 1ps

module play(clk,rst,data);

input         clk,rst;
output [55:0] data;
reg    [55:0] data;
reg    [55:0] temp_data;

always @(posedge clk or posedge rst) 
begin
	if (rst) begin data <= 0; end
	else data <= temp_data|data;
end

reg [32:0] cnt;

always @(posedge clk or posedge rst) 
begin
	if (rst) 
	begin 
		cnt <= 0; 
		temp_data<={55'b0,1'b1};
	end
	else begin
		cnt <= cnt + 1;
		if (cnt == 10000000) 
		begin 
			cnt <= 0;
			temp_data<=(temp_data<<1);
			if (temp_data == {1'b1,55'b0}) 
			begin 
				temp_data<={55'b0,1'b1}; 
			end   
		end
	end
end

endmodule
