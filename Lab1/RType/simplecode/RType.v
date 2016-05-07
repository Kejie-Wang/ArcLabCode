`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:29:59 03/07/2016 
// Design Name: 
// Module Name:    RType 
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
module Rtype(clk, rst, instru, Adat, Bdat, result);
    input clk;
    input rst;
    input [31:0] instru;
    output [31:0] result, Adat, Bdat;


	RegFile M0(clk, instru[25:21], instru[20:16], instru[15:11], result, Adat, Bdat, 1);
	
	single_alu M1(Adat, Bdat, i_aluc, o_zf, result);
	
	single_aluc M2(2'b10,instru[3:0],i_aluc);
endmodule

