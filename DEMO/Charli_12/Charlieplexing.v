`timescale 1ns / 1ps

module Charlieplexing(clk,rst,data,charli_pin);
input clk,rst;
input  [11:0] data;
inout  [3:0] charli_pin;
reg    [3:0] charli;

assign charli_pin[0] = charli[0]||(!charli[0])?charli[0]:1'bz;
assign charli_pin[1] = charli[1]||(!charli[1])?charli[1]:1'bz;
assign charli_pin[2] = charli[2]||(!charli[2])?charli[2]:1'bz;
assign charli_pin[3] = charli[3]||(!charli[3])?charli[3]:1'bz;

//++++++++++++++++++++++++++++++++++++++
// 分频部分 开�
//++++++++++++++++++++++++++++++++++++++
reg [12:0] cnt;                         

always @ (posedge clk or posedge rst)
  if (rst)
    cnt <= 0;
  else cnt <= cnt + 1'b1;

wire display_clk = cnt[12];

//--------------------------------------
// 分频部分 结束
//--------------------------------------


//++++++++++++++++++++++++++++++++++++++
// 动态扫� 生成charli_addr 开�
//++++++++++++++++++++++++++++++++++++++
reg [3:0]  charli_addr; 

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
	    4'b0000  : if((data[0 ])&&(!rst)) charli<={1'b0,1'b1,1'bZ,1'bZ}; else charli<={1'bZ,1'bZ,1'bZ,1'bZ};
	    4'b0001  : if(data[1 ]) charli<={4'bZ01Z}; else charli<={4'BZZZZ};
	    4'b0010  : if(data[2 ]) charli<={4'BZZ01}; else charli<={4'BZZZZ};
	    4'b0011  : if(data[3 ]) charli<={4'B10ZZ}; else charli<={4'BZZZZ};
	    4'b0100  : if(data[4 ]) charli<={4'BZ10Z}; else charli<={4'BZZZZ};
	    4'b0101  : if(data[5 ]) charli<={4'BZZ10}; else charli<={4'BZZZZ};
	    4'b0110  : if(data[6 ]) charli<={4'B0Z1Z}; else charli<={4'BZZZZ};
	    4'b0111  : if(data[7 ]) charli<={4'BZ0Z1}; else charli<={4'BZZZZ};
	    4'b1000  : if(data[8 ]) charli<={4'B1Z0Z}; else charli<={4'BZZZZ};
	    4'b1001  : if(data[9 ]) charli<={4'BZ1Z0}; else charli<={4'BZZZZ};
	    4'b1010  : if(data[10]) charli<={4'B0ZZ1}; else charli<={4'BZZZZ};
	    4'b1011  : if(data[11]) charli<={4'B1ZZ0}; else charli<={4'BZZZZ};           
	    default :               charli<={4'BZZZZ};
  endcase
end

endmodule
