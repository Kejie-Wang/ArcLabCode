`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:35 03/25/2016 
// Design Name: 
// Module Name:    single_alu 
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
module single_alu(i_r,i_s,i_aluc,o_zf,o_alu);
	
	input [31:0] i_r;		//r input
	input [31:0] i_s;		//s input
	input [2:0] i_aluc;		//i_aluc: ctrl input
	
	output o_zf;			//o_zf: zero flag output
	output [31:0] o_alu;	//o_alu: alu result output
	
	reg o_zf;
	reg [31:0] o_alu;
	
	//ALU CONTROL CODES
	`define ALU_CTL_AND	3'b000	//and
	`define ALU_CTL_OR	3'b001	//or
	`define ALU_CTL_ADD	3'b010	//add
	`define ALU_CTL_SUB	3'b110	//sub
	`define ALU_CTL_SLT	3'b111	//slt
	
	`define ALU_CTL_NOR 	3'b100	//nor
	`define ALU_CTL_XOR	3'b011	//xor
	
	always @(i_aluc or i_r or i_s) 
		begin
			case (i_aluc)
				`ALU_CTL_AND	: o_alu = i_r & i_s;
				`ALU_CTL_OR		: o_alu = i_r | i_s;
				`ALU_CTL_ADD	: o_alu = i_r + i_s;
				`ALU_CTL_SUB	: o_alu = i_r - i_s;
				`ALU_CTL_SLT	: begin
					o_alu = i_r - i_s;
					o_alu = {{31{1'b0}},o_alu[31]};
				end
				`ALU_CTL_XOR  	: o_alu = i_r ^ i_s;
				`ALU_CTL_NOR 	: o_alu = ~(i_r | i_s);
			endcase
			
			o_zf = ~(|o_alu);
	end
	
endmodule

