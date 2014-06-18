`timescale 1 ns / 1 ns


module timer(clk, reset, start, data_out);
   input         clk;
   input         reset;
   input         start;
   output [23:0] data_out;
   
   reg           clk_div;
   reg           flag;
   reg [19:0]    count;
   reg [3:0]     hs_g;
   reg [3:0]     hs_s;
   reg [3:0]     s_g;
   reg [3:0]     s_s;
   reg [3:0]     m_g;
   reg [3:0]     m_s;
   
   
   always @(posedge clk)
      
      begin
         if (reset == 1'b1)
            count <= {20{1'b0}};
         else if (count == 20'b11110100001001000000)
            count <= {20{1'b0}};
         else
            if (flag == 1'b1)
               count <= count + 1;
      end
   
   
   always @(posedge clk)
      
      begin
         if (reset == 1'b1)
            flag <= 1'b0;
         else if (start == 1'b1)
            flag <= ((~(flag)));
      end
   
   
   always @(posedge clk)
      
      begin
         if (count == 20'b11110100001001000000)
            clk_div <= 1'b1;
         else
            clk_div <= 1'b0;
      end
   
   
   always @(posedge clk_div or posedge reset)
      if (reset == 1'b1)
      begin
         hs_g <= {4{1'b0}};
         hs_s <= {4{1'b0}};
         s_g <= {4{1'b0}};
         s_s <= {4{1'b0}};
         m_g <= {4{1'b0}};
         m_s <= {4{1'b0}};
      end
      else 
      begin
         if (hs_g == 4'b1001)
         begin
            hs_s <= hs_s + 1;
            hs_g <= {4{1'b0}};
            if (hs_s == 4'b1001)
            begin
               s_g <= s_g + 1;
               hs_s <= {4{1'b0}};
               if (s_g == 4'b1001)
               begin
                  s_s <= s_s + 1;
                  s_g <= {4{1'b0}};
                  if (s_s == 4'b0101)
                  begin
                     m_g <= m_g + 1;
                     s_s <= {4{1'b0}};
                     if (m_g == 4'b1001)
                     begin
                        m_s <= m_s + 1;
                        m_g <= {4{1'b0}};
                        if (m_s == 4'b0101)
                           m_s <= {4{1'b0}};
                     end
                  end
               end
            end
         end
         else
            hs_g <= hs_g + 1;
      end
   
   assign data_out[23:20] = m_s;
   assign data_out[19:16] = m_g;
   
   assign data_out[15:12] = s_s;
   assign data_out[11:8] = s_g;
   
   assign data_out[7:4] = hs_s;
   assign data_out[3:0] = hs_g;
   
endmodule


