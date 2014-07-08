module Charlieplexing(clk,rst,data,charli_pin);
input clk,rst;
input  [55:0] data;
inout  [7:0] charli_pin;
reg    [7:0] charli;

assign charli_pin[0] = charli[0]||(!charli[0])?charli[0]:1'bz;
assign charli_pin[1] = charli[1]||(!charli[1])?charli[1]:1'bz;
assign charli_pin[2] = charli[2]||(!charli[2])?charli[2]:1'bz;
assign charli_pin[3] = charli[3]||(!charli[3])?charli[3]:1'bz;
assign charli_pin[4] = charli[4]||(!charli[4])?charli[4]:1'bz;
assign charli_pin[5] = charli[5]||(!charli[5])?charli[5]:1'bz;
assign charli_pin[6] = charli[6]||(!charli[6])?charli[6]:1'bz;
assign charli_pin[7] = charli[7]||(!charli[7])?charli[7]:1'bz;

//++++++++++++++++++++++++++++++++++++++
// 分频部分 开�
//++++++++++++++++++++++++++++++++++++++
reg [32:0] cnt;                         
reg display_clk;
always @ (posedge clk or posedge rst)
begin
	if (rst) 
	begin
		cnt <= 0;
		display_clk <= 0;
	end
	else 
	begin
  		cnt <= cnt + 1'b1;
  		if (cnt == 3000) 
  		begin
			cnt <= 0;
  			display_clk <= ~display_clk;
  		end
  	end
end


//--------------------------------------
// 分频部分 结束
//--------------------------------------


//++++++++++++++++++++++++++++++++++++++
// 动态扫� 生成charli_addr 开�
//++++++++++++++++++++++++++++++++++++++
reg [6:0]  charli_addr; 

always @ (posedge display_clk or posedge rst)
  if (rst)
    charli_addr <= 0;
  else begin
    charli_addr <= charli_addr + 1'b1;
    if(charli_addr == 56)  charli_addr <= 0;  
	end
//--------------------------------------
// 动态扫� 生成display_clk 结束
//--------------------------------------

always @ (charli_addr,data)
begin
	case (charli_addr)
	0   : if(data[0 ]) charli<={8'b01ZZZZZZ}; else charli<={8'bZZZZZZZZ};
	1   : if(data[1 ]) charli<={8'b10ZZZZZZ}; else charli<={8'bZZZZZZZZ};
	2   : if(data[2 ]) charli<={8'b0Z1ZZZZZ}; else charli<={8'bZZZZZZZZ};
	3   : if(data[3 ]) charli<={8'b1Z0ZZZZZ}; else charli<={8'bZZZZZZZZ};
	4   : if(data[4 ]) charli<={8'b0ZZ1ZZZZ}; else charli<={8'bZZZZZZZZ};
	5   : if(data[5 ]) charli<={8'b1ZZ0ZZZZ}; else charli<={8'bZZZZZZZZ};
	6   : if(data[6 ]) charli<={8'b0ZZZ1ZZZ}; else charli<={8'bZZZZZZZZ};
	7   : if(data[7 ]) charli<={8'b1ZZZ0ZZZ}; else charli<={8'bZZZZZZZZ};
	8   : if(data[8 ]) charli<={8'b0ZZZZ1ZZ}; else charli<={8'bZZZZZZZZ};
	9   : if(data[9 ]) charli<={8'b1ZZZZ0ZZ}; else charli<={8'bZZZZZZZZ};
	10  : if(data[10]) charli<={8'b0ZZZZZ1Z}; else charli<={8'bZZZZZZZZ};
	11  : if(data[11]) charli<={8'b1ZZZZZ0Z}; else charli<={8'bZZZZZZZZ};
	12  : if(data[12]) charli<={8'b0ZZZZZZ1}; else charli<={8'bZZZZZZZZ};
	13  : if(data[13]) charli<={8'b1ZZZZZZ0}; else charli<={8'bZZZZZZZZ};
	14  : if(data[14]) charli<={8'bZ01ZZZZZ}; else charli<={8'bZZZZZZZZ};
	15  : if(data[15]) charli<={8'bZ10ZZZZZ}; else charli<={8'bZZZZZZZZ};
	16  : if(data[16]) charli<={8'bZ0Z1ZZZZ}; else charli<={8'bZZZZZZZZ};
	17  : if(data[17]) charli<={8'bZ1Z0ZZZZ}; else charli<={8'bZZZZZZZZ};
	18  : if(data[18]) charli<={8'bZ0ZZ1ZZZ}; else charli<={8'bZZZZZZZZ};
	19  : if(data[19]) charli<={8'bZ1ZZ0ZZZ}; else charli<={8'bZZZZZZZZ};
	20  : if(data[20]) charli<={8'bZ0ZZZ1ZZ}; else charli<={8'bZZZZZZZZ};
	21  : if(data[21]) charli<={8'bZ1ZZZ0ZZ}; else charli<={8'bZZZZZZZZ};
	22  : if(data[22]) charli<={8'bZ0ZZZZ1Z}; else charli<={8'bZZZZZZZZ};
	23  : if(data[23]) charli<={8'bZ1ZZZZ0Z}; else charli<={8'bZZZZZZZZ};
	24  : if(data[24]) charli<={8'bZ0ZZZZZ1}; else charli<={8'bZZZZZZZZ};
	25  : if(data[25]) charli<={8'bZ1ZZZZZ0}; else charli<={8'bZZZZZZZZ};
	26  : if(data[26]) charli<={8'bZZ01ZZZZ}; else charli<={8'bZZZZZZZZ};
	27  : if(data[27]) charli<={8'bZZ10ZZZZ}; else charli<={8'bZZZZZZZZ};
	28  : if(data[28]) charli<={8'bZZ0Z1ZZZ}; else charli<={8'bZZZZZZZZ};
	29  : if(data[29]) charli<={8'bZZ1Z0ZZZ}; else charli<={8'bZZZZZZZZ};
	30  : if(data[30]) charli<={8'bZZ0ZZ1ZZ}; else charli<={8'bZZZZZZZZ};
	31  : if(data[31]) charli<={8'bZZ1ZZ0ZZ}; else charli<={8'bZZZZZZZZ};
	32  : if(data[32]) charli<={8'bZZ0ZZZ1Z}; else charli<={8'bZZZZZZZZ};
	33  : if(data[33]) charli<={8'bZZ1ZZZ0Z}; else charli<={8'bZZZZZZZZ};
	34  : if(data[34]) charli<={8'bZZ0ZZZZ1}; else charli<={8'bZZZZZZZZ};
	35  : if(data[35]) charli<={8'bZZ1ZZZZ0}; else charli<={8'bZZZZZZZZ};
	36  : if(data[36]) charli<={8'bZZZ01ZZZ}; else charli<={8'bZZZZZZZZ};
	37  : if(data[37]) charli<={8'bZZZ10ZZZ}; else charli<={8'bZZZZZZZZ};
	38  : if(data[38]) charli<={8'bZZZ0Z1ZZ}; else charli<={8'bZZZZZZZZ};
	39  : if(data[39]) charli<={8'bZZZ1Z0ZZ}; else charli<={8'bZZZZZZZZ};
	40  : if(data[40]) charli<={8'bZZZ0ZZ1Z}; else charli<={8'bZZZZZZZZ};
	41  : if(data[41]) charli<={8'bZZZ1ZZ0Z}; else charli<={8'bZZZZZZZZ};
	42  : if(data[42]) charli<={8'bZZZ0ZZZ1}; else charli<={8'bZZZZZZZZ};
	43  : if(data[43]) charli<={8'bZZZ1ZZZ0}; else charli<={8'bZZZZZZZZ};
	44  : if(data[44]) charli<={8'bZZZZ01ZZ}; else charli<={8'bZZZZZZZZ};
	45  : if(data[45]) charli<={8'bZZZZ10ZZ}; else charli<={8'bZZZZZZZZ};
	46  : if(data[46]) charli<={8'bZZZZ0Z1Z}; else charli<={8'bZZZZZZZZ};
	47  : if(data[47]) charli<={8'bZZZZ1Z0Z}; else charli<={8'bZZZZZZZZ};
	48  : if(data[48]) charli<={8'bZZZZ0ZZ1}; else charli<={8'bZZZZZZZZ};
	49  : if(data[49]) charli<={8'bZZZZ1ZZ0}; else charli<={8'bZZZZZZZZ};
	50  : if(data[50]) charli<={8'bZZZZZ01Z}; else charli<={8'bZZZZZZZZ};
	51  : if(data[51]) charli<={8'bZZZZZ10Z}; else charli<={8'bZZZZZZZZ};
	52  : if(data[52]) charli<={8'bZZZZZ0Z1}; else charli<={8'bZZZZZZZZ};
	53  : if(data[53]) charli<={8'bZZZZZ1Z0}; else charli<={8'bZZZZZZZZ};
	54  : if(data[54]) charli<={8'bZZZZZZ01}; else charli<={8'bZZZZZZZZ};
	55  : if(data[55]) charli<={8'bZZZZZZ10}; else charli<={8'bZZZZZZZZ};
	    default :      charli<={8'bZZZZZZZZ};
  endcase
end

endmodule
