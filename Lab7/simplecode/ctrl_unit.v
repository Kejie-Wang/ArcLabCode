`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:47 04/07/2016 
// Design Name: 
// Module Name:    ctrl_unit
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

module ctrl_unit(clk, rst, instr, 
	cu_branch, cu_wreg, cu_m2reg, cu_wmem, cu_aluc, cu_shift, cu_aluimm, cu_sext,cu_regrt, cu_lui, cu_jr, cu_jal);
	
			input clk, rst;
			input [31:0] instr;
			
			output reg cu_branch;
			output reg cu_wreg;
			output reg cu_m2reg;
			output reg cu_wmem;
			output reg [3:0] cu_aluc;
			output reg cu_shift;
			output reg cu_aluimm;
			output cu_sext;
			output reg cu_regrt;
			
			output reg cu_lui;
			output cu_jr;
			output reg cu_jal;
			
			wire [5:0] func;
			wire [5:0] opcode;
			wire [4:0] rs;
			wire [4:0] rt;
			wire [4:0] rd;
			
			assign opcode[5:0] =instr[31:26];
			assign rs[4:0] = instr[25:21];
			assign rt[4:0] = instr[20:16];
			assign rd[4:0] = instr[15:11];
			assign func[5:0] = instr[5:0];
			
			assign cu_sext = (opcode == `OP_ADDIU || opcode == `OP_SLTIU || opcode == `OP_ORI || opcode == `OP_ANDI || opcode == `OP_XORI) ? 0 : 1;//when   need to sign extend
			assign cu_jr = ((opcode == `OP_ALUOp) && (func == `FUNC_JR));
			always @(posedge clk or posedge rst) begin
					if(rst) begin 
						cu_branch <=0; 
						cu_wreg <=0;
						cu_m2reg <=0;
						cu_wmem <=0;
						cu_aluc <= 0;
						cu_shift <=0;
						cu_aluimm <=0;
						cu_regrt <= 0;
					end
					else begin
						cu_branch <= (opcode == `OP_BEQ) ? 1 : 0; //if instr type == BEQ then 1 else 0				
						cu_wreg <= (opcode == `OP_SW || opcode == `OP_BEQ || opcode == `OP_BNE || opcode == `OP_JMP) ? 0 : 1; //when need to write reg?
						cu_m2reg <= (opcode == `OP_LW) ? 1 : 0;//when need to write mem to reg ?
						cu_wmem <= (opcode == `OP_SW) ? 1 : 0;//when need to enable write mem?
						cu_shift <= ((opcode == `OP_ALUOp) && (func==`FUNC_SLL || func==`FUNC_SRL || func==`FUNC_SRA))? 1 : 0;
						cu_aluimm <=(opcode == `OP_ALUOp || opcode == `OP_BEQ) ? 0 : 1;
						cu_regrt <= (opcode == `OP_ALUOp) ? 0 : 1; //if instr type = R type then 0 else 1;
						
						cu_lui <= (opcode == `OP_LUI);
						cu_jal <= (opcode == `OP_JAL);
						case(opcode)
							`OP_LW: begin
								cu_aluc <= `ALU_ADD;
							end
							`OP_SW: begin
								cu_aluc <= `ALU_ADD;
							end
							`OP_BEQ: begin
								cu_aluc <= `ALU_SUB;
							end
							`OP_BNE: begin
								cu_aluc <= `ALU_SUB;
							end
							`OP_ADDI: begin
								cu_aluc <= `ALU_ADD;
							end
							`OP_ADDIU: begin
								cu_aluc <= `ALU_ADD;
							end
							`OP_ANDI: begin
								cu_aluc <= `ALU_AND;
							end
							`OP_ORI: begin
								cu_aluc <= `ALU_OR;
							end
							`OP_XORI: begin
								cu_aluc <= `ALU_XOR;
							end
							`OP_SLTI: begin
								cu_aluc <= `ALU_SLT;
							end
							`OP_SLTIU: begin
								cu_aluc <= `ALU_SLTU;
							end
							`OP_ALUOp: begin
								case(func)
									`FUNC_ADD: begin
										cu_aluc <= `ALU_ADD;
									end
									`FUNC_ADDU: begin
										cu_aluc <= `ALU_ADD;
									end
									`FUNC_SUB: begin
										cu_aluc <= `ALU_SUB;
									end
									`FUNC_AND: begin
										cu_aluc <= `ALU_AND;
									end
									`FUNC_OR: begin
										cu_aluc <= `ALU_OR;
									end
									`FUNC_XOR: begin
										cu_aluc <= `ALU_XOR;
									end
									`FUNC_NOR: begin
										cu_aluc <= `ALU_NOR;
									end
									`FUNC_SLT: begin
										cu_aluc <= `ALU_SLT;
									end
									`FUNC_SLTU: begin
										cu_aluc <= `ALU_SLTU;
									end
									`FUNC_SLL: begin
										cu_aluc <= `ALU_SLL;
									end
									`FUNC_SRL: begin
										cu_aluc <= `ALU_SRL;
									end
									`FUNC_SRA: begin
										cu_aluc <= `ALU_SRA;
									end
									`FUNC_SLLV: begin
										cu_aluc <= `ALU_SRL;
									end
									`FUNC_SRLV: begin
										cu_aluc <= `ALU_SRA;
									end
									`FUNC_JR: begin
										
									end
									default: cu_aluc <= `ALU_ADD;
								endcase
							end
							default: begin
							
							end	
						endcase
					end	//end else
				end
endmodule
