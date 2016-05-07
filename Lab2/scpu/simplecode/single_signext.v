`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:31:17 03/25/2016 
// Design Name: 
// Module Name:    single_signext 
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
module single_signext(in, out);
	input [15:0] in;
	output [31:0] out;
	reg [31:0] out;

	always @(in) begin
			if(in[15] == 1'b1)
				out <= {{16'b1111111111111111},in};
			else
				out <= {{16'b0000000000000000},in};
	end  
endmodule

