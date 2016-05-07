`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:33:08 03/25/2016 
// Design Name: 
// Module Name:    single_ctl 
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

module 	single_ctl(input reset,
				   input [31:26]opcode,
				   output reg regdst,											 
				   output reg jump,											 
				   output reg branch,											 
				   output reg memread,
				   output reg memtoreg,											 
				   output reg [1:0]aluop,											 
				   output reg memwrite,											 
				   output reg alusrc,											 
				   output reg regwrite
				   );
								 
		always @(*) begin
			case(opcode) 
				`INSTR_RTYPE: begin
					regdst	<= 1'b1;
					jump 		<= 1'b0;
					branch	<= 1'b0;
					memread	<= 1'b0;
					memtoreg	<= 1'b0;
					aluop		<= 2'b10;
					memwrite	<= 1'b0;
					alusrc	<= 1'b0;
					regwrite	<= 1'b1;
				end
				`INSTR_JUMP:  begin
					regdst	<= 1'bx;
					jump 		<= 1'b1;
					branch	<= 1'b0;
					memread	<= 1'b0;
					memtoreg	<= 1'bx;
					aluop		<= 2'bxx;
					memwrite	<= 1'b0;
					alusrc	<= 1'bx;
					regwrite	<= 1'b0;
				end
				`INSTR_BEQ:	 begin
					regdst	<= 1'bx;
					jump 		<= 1'b0;
					branch	<= 1'b1;
					memread	<= 1'b0;
					memtoreg	<= 1'bx;
					aluop		<= 2'b11;
					memwrite	<= 1'b0;
					alusrc	<= 1'b0;
					regwrite	<= 1'b0;
				end
				`INSTR_SW:	 begin
					regdst	<= 1'bx;
					jump 		<= 1'b0;
					branch	<= 1'b0;
					memread	<= 1'b0;
					memtoreg	<= 1'bx;
					aluop		<= 2'b00;
					memwrite	<= 1'b1;
					alusrc	<= 1'b1;
					regwrite	<= 1'b0;
				end
				`INSTR_LW:	 begin
					regdst	<= 1'b0;
					jump 		<= 1'b0;
					branch	<= 1'b0;
					memread	<= 1'b1;
					memtoreg	<= 1'b1;
					aluop		<= 2'b00;
					memwrite	<= 1'b0;
					alusrc	<= 1'b1;
					regwrite	<= 1'b1;
				end
			endcase
		end	

endmodule