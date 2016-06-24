`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:47 04/07/2016 
// Design Name: 
// Module Name:    id_stage
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

module id_stage (clk, 
					  rst, 
					  if_inst, 
					  if_pc4, 
					  
					  wb_destR, //write address
					  wb_dest,	//write data
					  wb_wreg,	//write enable
					  
					  cu_wreg, //the instr whether write reg
					  cu_m2reg, //whether the instr write from mem to reg
					  cu_wmem, 	//whether the instr write mem(=1 when sw)
					  cu_aluc, 	//alu operation
					  cu_shift, //
					  cu_aluimm, //the second operand of alu is imme or reg2
					  cu_branch, //whether the instr is a branch
					  
					  cu_lui,
					  cu_jmp,
					  cu_jmp_pc,
					  cu_jr,
					  cu_jal,
					  id_inst,
					  id_pc4, 	//instruction decode pc+4
					  id_inA, 	//read data A
					  id_inB, 	//read data B
					  id_imm, 	//immediate
					  cu_regrt, //write data address 1:rt, 0:rd
					  rs,
					  rt, 		//rt address
					  rd,			//rd address
					  
					  IF_ins_type, 
					  IF_ins_number, 					  
					  ID_ins_type, 
					  ID_ins_number, 
					  
					  which_reg, 	//read which reg					  
					  reg_content,	//read content = regs[which_reg]
					  aluR,
					  destR,
					  ex_aluR,
					  ex_destR,
					  id_beq,
					  id_beq_pc
					  );
	
			input clk;
			input rst;
			input [31:0] if_inst;
			input [31:0] if_pc4;
			
			input [4:0] wb_destR;
			input [31:0] wb_dest; 
			input wb_wreg;
			
			input[3:0] IF_ins_type;
			input[3:0]	IF_ins_number;
			
			input [4:0] which_reg;
			output [31:0] reg_content;
			
			output cu_branch;
			output cu_wreg;
			output cu_m2reg;
			output cu_wmem;
			output [3:0] cu_aluc;
			output cu_shift;
			output cu_aluimm;
			output cu_regrt;
			
			output cu_lui;
			output reg cu_jmp;
			output cu_jr;
			output cu_jal;
			output wire[31:0] cu_jmp_pc;
			
			output reg [31:0] id_inst;
			output reg [31:0] id_pc4;
			output reg [31:0] id_inA;
			output reg [31:0] id_inB;
			output reg [31:0] id_imm;			
			output reg [4:0] rd;
			output reg [4:0] rt;
			output reg [4:0] rs;
			
			output reg [3:0] ID_ins_type;
			output reg [3:0] ID_ins_number;	
			
			input [31:0] aluR, ex_aluR;
			input [4:0] destR, ex_destR;
			
			output reg id_beq;
			output reg [31:0]id_beq_pc;
			
			wire cu_sext;
			wire [31:0] rdata_A;
			wire [31:0] rdata_B;
			wire [15:0] imm;
			
			wire[4:0] if_rs, if_rt;
					
			assign imm = if_inst[15:0];
			//forward not taken
			//advance the branch test to id
			//only one stall after the beq
			wire[5:0] opcode;
			wire[31:0]forward_A, forward_B;
			
			assign opcode = if_inst[31:26];
			assign if_rs = cu_jr ? 31 : if_inst[25:21];
			assign if_rt = if_inst[20:16];
			assign forward_A = (if_rs == ex_destR && if_rs != 0)?ex_aluR:((if_rs == destR && if_rs != 0) ? aluR : rdata_A);
			assign forward_B = (if_rt == ex_destR && if_rt != 0)?ex_aluR:((if_rt == destR && if_rt != 0) ? aluR : rdata_B);

			//assign cu_jmp = (opcode == `OP_JMP) || (opcode == `OP_JAL);
			assign cu_jmp_pc = cu_jr ? forward_A : {6'b0, if_inst[25:0]};
			
			always @(*) begin
				if(rst)
					cu_jmp <= 0;
				else
					cu_jmp <=(opcode == `OP_JMP) || (opcode == `OP_JAL) || cu_jr;
			end
			
			//	assign 
			always @ (posedge clk or posedge rst)
				if (rst==1)begin			
					ID_ins_type <= 4'b0;
					ID_ins_number <= 4'b0;
					id_inst <= 32'b0;
					id_pc4 <= 32'b0;
					id_imm <= 32'b0;
					rt <= 5'b0;
					rd <= 5'b0;		
					rs <= 5'b0;
					id_inA <= 0;
					id_inB <= 0;
				end
				else
				begin		
					ID_ins_type <= IF_ins_type;
					ID_ins_number <= IF_ins_number;
					id_inst <= if_inst;
					id_pc4 <= if_pc4;			
					id_imm <= cu_sext?( imm[15]?{16'hffff,imm}:{16'b0,imm}):{16'b0,imm};	//immediate extend
					rs <= if_inst[25:21];
					rt <= if_inst[20:16];
					rd <= (opcode == `OP_JAL) ? 31 : if_inst[15:11];	
					id_inA <= rdata_A;
					id_inB <= rdata_B;							
				end
			
			always @(*)
			if(rst) begin
				id_beq <= 0;
				id_beq_pc <=0;
			end
			else begin
				id_beq <= (((opcode == `OP_BEQ) & (forward_A == forward_B)) || ((opcode == `OP_BNE) & (forward_A != forward_B)) );	
				id_beq_pc <= (if_pc4 + ( imm[15]?{16'hffff,imm}:{16'b0,imm}));
			end
			regfile x_regfile(clk, 
									rst, 
									if_rs, //rs
									if_rt, //rt
									wb_destR, 		//write address
									wb_dest, 		//write data
									wb_wreg,			//write enable
									rdata_A, 		//read data A
									rdata_B,			//read data B				
									which_reg, 		//read which reg
									reg_content		//read content = regs[which_reg]
									);
									
			ctrl_unit x_ctrl_unit(clk, 
										 rst, 
										 if_inst[31:0], 			
										 cu_branch, 
										 cu_wreg, //the instr whether write reg
										 cu_m2reg, //the instr whether write from mem to reg
										 cu_wmem, //the instr whether write mem(=1 when sw)
										 cu_aluc, 
										 cu_shift, 
										 cu_aluimm, 
										 cu_sext,
										 cu_regrt,
										 cu_lui,
										 cu_jr,
										 cu_jal
										 );
			
endmodule
