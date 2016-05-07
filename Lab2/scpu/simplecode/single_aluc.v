`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:31:46 03/25/2016 
// Design Name: 
// Module Name:    single_aluc 
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
//////////////////////////////////////////////////////////////////////////////////////
`include "macro.vh"
module single_aluc(aluop, func, aluc);
    input [1:0] aluop;
    input [5:0] func;
    output [2:0] aluc;
	 reg [2:0] aluc;
	
	 always @(aluop or func) begin
		case (aluop)
			2'b00: aluc = `ALUC_CTL_ADD;	//lw sw
			2'b11: aluc = `ALUC_CTL_SUB;	//beq bne
			2'b10: begin
				case(func)
					`RTYPE_ADD: aluc = `ALUC_CTL_ADD;
					`RTYPE_SUB: aluc = `ALUC_CTL_SUB;
					`RTYPE_AND: aluc = `ALUC_CTL_AND;
					`RTYPE_OR:  aluc = `ALUC_CTL_OR;
					`RTYPE_SLT: aluc = `ALUC_CTL_SLT;
					`RTYPE_XOR: aluc = `ALUC_CTL_XOR;
					`RTYPE_NOR: aluc = `ALUC_CTL_NOR;
					default: aluc = `ALUC_CTL_ADD;
				endcase
			end
		  default: aluc = `ALUC_CTL_ADD;	
		endcase
	end
endmodule
