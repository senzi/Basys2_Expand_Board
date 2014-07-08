`timescale 1ns / 1ps

module TOP(clk,rst,charli_pin);
input clk,rst;
inout [7:0] charli_pin;

wire [55:0] data;
play u1(
	.clk(clk),
	.rst(rst),
	.data(data));

Charlieplexing u2(
	.clk(clk),
	.rst(rst),
	.data(data),
	.charli_pin(charli_pin));
endmodule
