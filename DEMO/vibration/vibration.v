`timescale 1ns / 1ps

module vibration(rst,up,count_out);
input           rst,up;
output   [16:0] count_out;        


reg [3:0]     one;
reg [3:0]     two;
reg [3:0]     three;
reg [3:0]     four;

always @(posedge up or posedge rst)
      if (rst == 1'b1)
      begin
         one <= {4{1'b0}};
         two <= {4{1'b0}};
         three <= {4{1'b0}};
         four <= {4{1'b0}};
      end
      else 
      begin
         if (one == 4'b1001)
         begin
            two <= two + 1;
            one <= {4{1'b0}};
            if (two == 4'b1001)
            begin
               three <= three + 1;
               two <= {4{1'b0}};
               if (three == 4'b1001)
               begin
                  four <= four + 1;
                  three <= {4{1'b0}};
                  if (four == 4'b1001)
                  begin
                  	two <=4'b0001; 
                  	four <= {4{1'b0}};  
                  end
               end
            end
         end
         else
            one <= one + 1;
      end

assign count_out = {four,three,two,one};


endmodule

