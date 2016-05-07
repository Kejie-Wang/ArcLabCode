`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:27 03/07/2016 
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
//////////////////////////////////////////////////////////////////////////////////
`define ALUC_CTL_AND		3'b000
`define ALUC_CTL_OR		3'b001
`define ALUC_CTL_ADD		3'b010
`define ALUC_CTL_SUB		3'b110
`define ALUC_CTL_SLT		3'b111

`define ALUC_CTL_NOR 	3'b100
`define ALUC_CTL_XOR		3'b011

`define RTYPE_ADD		4'b0000
`define RTYPE_SUB		4'b0010
`define RTYPE_SLT		4'b1010
`define RTYPE_AND		4'b0100
`define RTYPE_OR		4'b0101
`define RTYPE_XOR		4'b0110
`define RTYPE_NOR		4'b0111
`define RTYPE_ADDU		4'b0001
`define RTYPE_SLTU		4'b1011

module single_aluc(aluop, func, aluc);
    input [1:0] aluop;
    input [5:0] func;
    output [2:0] aluc;
	 reg [2:0] aluc;
	
	 always @(aluop or func) begin
		case (aluop)
			2'b00: aluc = `ALUC_CTL_ADD;
			2'b11: aluc = `ALUC_CTL_SUB;
			2'b10: begin
				case(func)
					`RTYPE_ADD: aluc = `ALUC_CTL_ADD;	//0000
					`RTYPE_SUB: aluc = `ALUC_CTL_SUB;	//0010
					`RTYPE_AND: aluc = `ALUC_CTL_AND;	//1010
					`RTYPE_OR:  aluc = `ALUC_CTL_OR;		//
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
