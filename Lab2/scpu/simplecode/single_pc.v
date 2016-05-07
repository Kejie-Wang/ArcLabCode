`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:42 03/25/2016 
// Design Name: 
// Module Name:    single_pc 
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
module single_pc(clk,rst,ipc,opc);
		input clk;
		input rst;
 		input [8:0] ipc;
  		output [8:0] opc;
		wire [8:0] tpc;
		
		dff x_dff(rst,clk,ipc,tpc);	//tpc = ipc
		sel x_sel(rst,tpc,opc);	//opc = rst ? 9'b111111111 : tpc;
endmodule

