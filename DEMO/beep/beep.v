module fp_verilog(out,clk);

output out;
input clk;

reg[32:0] cn;
reg out;

always@(posedge clk)
begin
	cn<=cn+1'b1;
	if (cn[32]==1'B1)
		begin
			cn<=32'd0;
			out<=~out;
		end
end

endmodule