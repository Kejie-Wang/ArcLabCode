`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:15 03/25/2016 
// Design Name: 
// Module Name:    single_mux5 
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
module single_mux5(Ai,Bi,sel,out);
 		 input [4:0] Ai;
  		input [4:0] Bi;
  		input sel;
  		output [4:0] out;
  
  		assign out[4:0] = (sel == 1) ? (Bi[4:0]) : (Ai[4:0]);
endmodule
