`timescale 1ns / 1ps

module Charlieplexing(clk,rst,data,charli_pin);
input clk,rst;
input  [5:0] data;
inout  [2:0] charli_pin;
reg    [2:0] charli;

assign charli_pin[0] = charli[0]||(!charli[0])?charli[0]:1'bz;
assign charli_pin[1] = charli[1]||(!charli[1])?charli[1]:1'bz;
assign charli_pin[2] = charli[2]||(!charli[2])?charli[2]:1'bz;

//++++++++++++++++++++++++++++++++++++++
// 分频部分 开�
//++++++++++++++++++++++++++++++++++++++
reg [14:0] cnt;                         

always @ (posedge clk or posedge rst)
  if (rst)
    cnt <= 0;
  else cnt <= cnt + 1'b1;

wire display_clk = cnt[14];

//--------------------------------------
// 分频部分 结束
//--------------------------------------


//++++++++++++++++++++++++++++++++++++++
// 动态扫� 生成charli_addr 开�
//++++++++++++++++++++++++++++++++++++++
reg [2:0]  charli_addr; 

always @ (posedge display_clk or posedge rst)
  if (rst)
    charli_addr <= 0;
  else
    charli_addr <= charli_addr + 1'b1;      
//--------------------------------------
// 动态扫� 生成display_clk 结束
//--------------------------------------

always @ (charli_addr)
begin
	case (charli_addr)
	    0 : if(data[0]) charli<={1'b1,1'b0,1'bZ}; else charli<={1'bZ,1'bZ,1'bZ};
	    1 : if(data[1]) charli<={1'b0,1'b1,1'bZ}; else charli<={1'bZ,1'bZ,1'bZ};
	    2 : if(data[2]) charli<={1'b1,1'bZ,1'b0}; else charli<={1'bZ,1'bZ,1'bZ};
	    3 : if(data[3]) charli<={1'b0,1'bZ,1'b1}; else charli<={1'bZ,1'bZ,1'bZ};
	    4 : if(data[4]) charli<={1'bZ,1'b1,1'b0}; else charli<={1'bZ,1'bZ,1'bZ};
	    5 : if(data[5]) charli<={1'bZ,1'b0,1'b1}; else charli<={1'bZ,1'bZ,1'bZ};           
	    default :       charli<={1'bZ,1'bZ,1'bZ};
  endcase
end

endmodule
