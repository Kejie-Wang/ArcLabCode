`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:47 04/07/2016 
// Design Name: 
// Module Name:    if_stage
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

module if_stage (clk, 	//step 
					  rst, 	//reset
					  npc, 	//next pc
					  nid_pc, //the branch pc
					  ctrl_branch, //branch ctrl signal
					  
					  if_npc, //instruction fecth next pc = pc +4 | branch pc
					  if_pc4, //instruction fecth pc + 4
					  if_inst, //fecth instruction
					  IF_ins_type, //instruction type
					  IF_ins_number,//instruction number
					  ID_ins_type,
					  ID_ins_number,
					  
					  inst,
					  stall
					  );
				
			input clk;
			input rst;
			input [31:0] npc;
			input [31:0] nid_pc;
			input ctrl_branch;
			
			output [31:0] if_npc;
			output [31:0] if_pc4;
			output [31:0] if_inst;
			output [3:0] IF_ins_number;
			output [3:0] IF_ins_type;
			output [3:0] ID_ins_type;	//instruction decode type
			output [3:0] ID_ins_number;	//the instruction number = pc[3:0]
			
			output [31:0]inst;
			
			input stall;
			
			wire clk;
			wire rst;
			wire ctrl_branch;
			wire [31:0] nid_pc;
			wire [31:0] inst_m;
			reg [31:0] pc;
			reg run;
			reg [3:0] ID_ins_type;
			reg [3:0] ID_ins_number;
			reg [31:0]if_pc4;
			reg [31:0]if_inst;
			initial begin
				pc[31:0]=32'hffffffff;
				run = 1'b0;
				ID_ins_type[3:0] = 4'b0000;
				ID_ins_number[3:0] = 4'b0000;
			end

			assign if_npc = ctrl_branch ? nid_pc : pc + 1;
			assign IF_ins_number[3:0] = npc[3:0] ;
			assign IF_ins_type[3:0] = `INST_TYPE_NONE;
			
			
			//stall
			assign inst[31:0] = inst_m[31:0];
			always @ (posedge clk or posedge rst) begin
				/*if(ctrl_branch == 1) begin
					pc[31:0] <= npc[31:0];
				end*/
				if(rst == 1'b1) begin
					pc[31:0] <=32'hffffffff;
					if_pc4 <= 0;
					run <= 1'b0;
					if_inst <= 0;
				end
				else if(clk==1'b1) begin
					if(stall == 0) begin
						pc[31:0] <= npc[31:0];
					end
					if(ctrl_branch == 1) begin
						pc[31:0] <= npc[31:0];
					end
					run <= 1'b1;
					if_pc4 <= pc + 1;					
					if_inst[31:0] <= stall ? 0 : (run ? inst_m[31:0] : 0);
				end
			end

			always @(if_inst) begin
				if (run == 1'b0) begin	//for initial 0
					ID_ins_type[3:0] <= 4'b0000;
					ID_ins_number[3:0] <= 4'b0000;
				end
				else
				begin
					ID_ins_number[3:0] <= pc[3:0];
					case (if_inst[31:26])
						`OP_ALUOp: begin		//R-type
							case(if_inst[5:0])
								`FUNC_ADD: begin
									ID_ins_type <= `INST_TYPE_ADD;
									end
								`FUNC_SUB: begin
									ID_ins_type <= `INST_TYPE_SUB;
									end
								`FUNC_AND: begin
									ID_ins_type <= `INST_TYPE_AND;
									end
								`FUNC_OR: begin
									ID_ins_type <= `INST_TYPE_OR;
									end
								`FUNC_NOR: begin
									ID_ins_type <= `INST_TYPE_NOR;
									end
								`FUNC_SLT: begin
									ID_ins_type <= `INST_TYPE_SLT;
									end
								`FUNC_SLL: begin
									ID_ins_type <= `INST_TYPE_SLL;
									end
								`FUNC_SRL: begin
									ID_ins_type <= `INST_TYPE_SRL;
									end
								`FUNC_SRA: begin
									ID_ins_type <= `INST_TYPE_SRA;
									end
								default: begin
									ID_ins_type <= `INST_TYPE_NONE;
								end
							endcase
						end
						`OP_ADDI: begin
							ID_ins_type <= `INST_TYPE_ADD;
						end
						`OP_ANDI: begin
							ID_ins_type <= `INST_TYPE_AND;
						end
						`OP_ORI: begin
							ID_ins_type <= `INST_TYPE_OR;
						end
						`OP_LW: begin
							ID_ins_type <= `INST_TYPE_LW;
						end
						`OP_SW: begin
							ID_ins_type <= `INST_TYPE_SW;
						end
						`OP_BEQ: begin
							ID_ins_type <= `INST_TYPE_BEQ;
						end
						`OP_JMP: begin
							ID_ins_type <= `INST_TYPE_JMP;
						end
						`OP_BNE: begin
							ID_ins_type <= `INST_TYPE_BNE;
						end
						default: begin
							ID_ins_type <= `INST_TYPE_NONE;
						end
					endcase
				end
			end
			wire nclk = ~clk;
			instr_mem x_inst_mem(.addra(pc[7:0]),.clka(nclk),.douta(inst_m));
endmodule
