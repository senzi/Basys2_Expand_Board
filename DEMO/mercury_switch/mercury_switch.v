`timescale 1ns / 1ps


module mercury_switch(clk,rst,hg_in,hg_out);

input       clk,rst;
output [5:0]hg_out;

input  [3:0]hg_in;

reg    [5:0]state,hg_out;

parameter       S0 = 6'b000001,
                S1 = 6'b000010,
                S2 = 6'b000100,
                S3 = 6'b001000,
                S4 = 6'b010000,
                S5 = 6'b100000;

parameter       front = 4'b0000,
                back  = 4'b1111,
                up    = 4'b0110,
                down  = 4'b1001,
                left  = 4'b1100,
                right = 4'b0011;

always @ (posedge clk or posedge rst)
	if(rst) state <= S0;
	else    
		begin
			state <= hg_out;
		end
		
always @ (state or hg_in)
begin
	hg_out <= 6'bx;
	case(state)
	S0: begin
		     if(hg_in==back )hg_out <= S5;
		else if(hg_in==up   )hg_out <= S2;
		else if(hg_in==left )hg_out <= S3;
		else if(hg_in==right)hg_out <= S4;
		else                 hg_out <= S1;
		end

	S1: begin
		     if(hg_in==back )hg_out <= S5;
		else if(hg_in==up   )hg_out <= S2;
		else if(hg_in==left )hg_out <= S3;
		else if(hg_in==right)hg_out <= S4;
		else                 hg_out <= S1;
		end

	S2: begin
		     if(hg_in==back )hg_out <= S5;
		else if(hg_in==down )hg_out <= S1;
		else if(hg_in==left )hg_out <= S3;
		else if(hg_in==right)hg_out <= S4;
		else                 hg_out <= S2;
		end

	S3: begin
		     if(hg_in==back )hg_out <= S5;
		else if(hg_in==up   )hg_out <= S2;
		else if(hg_in==down )hg_out <= S1;
		else if(hg_in==right)hg_out <= S4;
		else                 hg_out <= S3;
		end

	S4: begin
		     if(hg_in==back )hg_out <= S5;
		else if(hg_in==up   )hg_out <= S2;
		else if(hg_in==down )hg_out <= S1;
		else if(hg_in==left )hg_out <= S3;
		else                 hg_out <= S4;
		end

	S5: begin
		if((hg_in==front)||(hg_in==down))hg_out <= S1;
		else if(hg_in==up   )hg_out <= S2;
		else if(hg_in==left )hg_out <= S3;
		else if(hg_in==right)hg_out <= S4;
		else                 hg_out <= S5;
		end

	default:  hg_out <= S1;
	endcase
end

endmodule
