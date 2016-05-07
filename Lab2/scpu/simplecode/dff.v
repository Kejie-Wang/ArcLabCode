`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:29:15 03/25/2016 
// Design Name: 
// Module Name:    dff 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dff(rst,clk,d,q);
		input rst;
		input clk;
		input [8:0] d;
		output [8:0] q;
		
		reg [8:0] q;
		
		initial begin
			q<=0;
		end
		
		always @ (posedge clk or posedge rst) begin
		if(rst)
			q <=9'b111111111;
		else
			q<= d;
		end
endmodule
