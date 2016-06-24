`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:47:26 04/12/2016 
// Design Name: 
// Module Name:    Alu 
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
`include "macro.vh"

module Alu(i_r,
		   i_s,
		   i_aluc,
		   o_alu
		   );
	
	input [31:0] i_r;		//r input
	input [31:0] i_s;		//s input
	input [3:0] i_aluc;		//i_aluc: ctrl input
	
	output reg [31:0] o_alu;	//o_alu: alu result output
	
	always @(*) 
		begin
			case (i_aluc)
				`ALU_ADD: o_alu = i_r + i_s;
				`ALU_SUB: o_alu = i_r - i_s;
				`ALU_AND: o_alu = i_r & i_s;
				`ALU_XOR: o_alu = i_r ^ i_s;
				`ALU_OR:  o_alu = i_r | i_s;
				`ALU_SLT	: begin
					o_alu = i_r - i_s;
					o_alu = {{31{1'b0}},o_alu[31]};
				end
				`ALU_SLTU: o_alu = (i_r < i_s) ? 1 : 0;
				`ALU_NOR: o_alu = ~(i_r | i_s);
				`ALU_SLL: o_alu = i_s << i_r;
				`ALU_SRL: o_alu = i_s >> i_r;
				`ALU_SRA: o_alu = {{31{i_s[31]}},i_s} >> i_r;
				`ALU_SLLV:o_alu = i_s << i_r;
				`ALU_SRLV:o_alu = i_s >> i_r;
				`ALU_SRAV:o_alu = i_s >>> i_r;
			endcase
	end
	
endmodule



