`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:37 05/07/2016 
// Design Name: 
// Module Name:    stall_ctr 
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
//macro.vh
//macro definitions

//operation code
`include "macro.vh"

module forward_ctr(clk,
						rst,
						id_inA,
						id_inB,
						
						id_rs,
						id_rt,
						ex_wreg,
						ex_destR,
						ex_aluR,
						 
						id_inA_forward,
						id_inB_forward,
						stall
						);
		
		input rst, clk;
		input [31:0]inst;
		input [31:0]if_inst;
		input [31:0]id_inst;
		
		output id_inA_forward, id_inB_forward;
		output reg stall;
		
		wire AfromEx, BfromEx, AfromExLW, BfromExLW;
		wire AfromMem, BfromMem, AfromMemLW, BfromMemLW;
		
		assign id_inA_forward = (ex_wreg && (exdestR != 0) && (exdestR == id_rs)) ? ex_aluR : id_inA;
		assign id_inB_forward = (ex_wreg && (exdestR != 0) && (exdestR == id_rt)) ? ex_aluR : id_inB;
		
		
		
		always @(*) begin
			if(rst)
				stall <=0;
			else
				stall <= AfromEx | BfromEx |AfromExLW | BfromExLW | AfromMem | BfromMem | AfromMemLW | BfromMemLW;
		end
endmodule
