`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:29:34 03/25/2016 
// Design Name: 
// Module Name:    sel 
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
module sel(rst,ipc,opc);
		input rst;
 		input [8:0] ipc;
  		output [8:0] opc;
		
		assign opc = rst ? 9'b111111111 : ipc;
endmodule

