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
					  id_pc4, 	//instruction decode pc+4
					  id_inA, 	//read data A
					  id_inB, 	//read data B
					  id_imm, 	//immediate
					  cu_regrt, //write data address 1:rt, 0:rd
					  rt, 		//rt address
					  rd,			//rd address
					  
					  IF_ins_type, 
					  IF_ins_number, 
					  ID_ins_type, 
					  ID_ins_number, 
					  which_reg, 	//read which reg
					  reg_content	//read content = regs[which_reg]
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
			output [31:0] id_pc4;
			output [31:0] id_inA;
			output [31:0] id_inB;
			output [31:0] id_imm;
			output cu_regrt;
			output [4:0] rd;
			output [4:0] rt;
			
			output[3:0] ID_ins_type;
			output[3:0] ID_ins_number;
			
			wire cu_sext;
			wire cu_regrt;
			wire cu_branch;
			
			reg [31:0] reg_inst;
			reg [31:0] pc4;
			
			wire [31:0] rdata_A;
			wire [31:0] rdata_B;
			wire [4:0] rt;
			wire [4:0] rd;
			wire [15:0] imm;
			wire [31:0] id_imm;
			
			wire [31:0] id_pc4;
			
			reg[3:0] ID_ins_type;
			reg[3:0] ID_ins_number;
			
			assign imm = reg_inst[15:0];
			assign rt= reg_inst[20:16];
			assign rd = reg_inst[15:11];
			assign id_imm = cu_sext?( imm[15]?{16'hffff,imm}:{16'b0,imm}):{16'b0,imm};	//immediate extend
			assign id_pc4 = if_pc4;
			
			always @ (posedge clk or posedge rst)
				if (rst==1)begin
					reg_inst <= 0;
					pc4 <= 0;				
					ID_ins_type <= 0;
					ID_ins_number <= 0;	
				end
				else
				begin
					reg_inst <= if_inst;
					pc4 <= if_pc4;				
					ID_ins_type <= IF_ins_type;
					ID_ins_number <= IF_ins_number;			
				end
			
			regfile x_regfile(clk, 
									rst, 
									reg_inst[25:21], //rs
									reg_inst[20:16], //rt
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
										 reg_inst[31:0],				
										 cu_branch, 
										 cu_wreg, //the instr whether write reg
										 cu_m2reg, //the instr whether write from mem to reg
										 cu_wmem, //the instr whether write mem(=1 when sw)
										 cu_aluc, 
										 cu_shift, 
										 cu_aluimm, 
										 cu_sext,
										 cu_regrt
										 );
			
			assign id_inA=rdata_A;
			assign id_inB=rdata_B;
endmodule
