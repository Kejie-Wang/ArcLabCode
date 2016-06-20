`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:47 04/07/2016 
// Design Name: 
// Module Name:    top 
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
 module top(input wire CCLK, 
		   input wire BTN3, 
		   input wire BTN2, 
		   input wire [3:0]SW, 
		   output wire LED, 
		   output wire LCDE, 
		   output wire LCDRS, 
		   output wire LCDRW, 
		   output wire [3:0]LCDDAT
		   );
			wire [31:0]inst;
			
			wire [31:0] if_npc;
			wire [31:0] if_pc4;
			wire [31:0] if_inst;
			
			wire [31:0] id_inst;		
			wire [31:0] id_pc4;	
			wire [31:0] id_inA;
			wire [31:0] id_inB;
			wire [31:0] id_inA_forward;
			wire [31:0] id_inB_forward;
			wire [31:0] id_imm;
			wire [4:0] id_destR;
			wire id_regrt;
			wire [4:0] id_rt;
			wire [4:0] id_rs;
			wire [4:0] id_rd;
			wire id_branch; 
			wire id_wreg;
			wire id_m2reg;
			wire id_wmem;
			wire [3:0] id_aluc;
			wire id_shift;
			wire id_aluimm;
			
			wire ex_wreg;
			wire ex_m2reg;
			wire ex_wmem;
			wire[31:0] ex_aluR;
			wire[31:0] ex_inB;
			wire[4:0] ex_destR;
			wire ex_branch,ex_zero;
			wire[31:0]ex_pc;
			
			wire mem_wreg;
			wire mem_m2reg;
			wire[31:0] mem_mdata;
			wire[31:0] mem_aluR;
			wire[4:0] mem_destR;
			wire[31:0] mem_pc;
			
			wire wb_wreg;
			wire[4:0] wb_destR;
			wire[31:0] wb_dest;
			
			wire [3:0] IF_ins_type; 
			wire [3:0] IF_ins_number;
			wire [3:0] ID_ins_type;
			wire [3:0] ID_ins_number;
			wire [3:0] EX_ins_type; 
			wire [3:0] EX_ins_number;
			wire [3:0] MEM_ins_type; 
			wire [3:0] MEM_ins_number;
			wire [3:0] WB_ins_type; 
			wire [3:0] WB_ins_number;
			wire [3:0] OUT_ins_type; 
			wire [3:0] OUT_ins_number;
			
			wire [31:0] pc;
			wire [31:0] reg_content;
			wire [3:0] which_reg;
			
			reg [255:0] strdata;
			reg [3:0] SW_old;
			reg [7:0] clk_cnt;
			reg cls;

			wire [3:0] lcdd;
			wire rslcd, rwlcd, elcd;
			wire clk_1ms;
			wire BTN3OUT;
			assign BTN3OUT = BTN3;
			assign LCDDAT[3]=lcdd[3];
			assign LCDDAT[2]=lcdd[2];
			assign LCDDAT[1]=lcdd[1];
			assign LCDDAT[0]=lcdd[0];
			
			assign LCDRS=rslcd;
			assign LCDRW=rwlcd;
			assign LCDE=elcd;
			
			assign LED=BTN3OUT;
			assign which_reg[3:0] = SW[3:0];

			wire rst;
			
			assign rst = BTN2;
			
			wire[31:0] aluR;
			wire[4:0] destR;
			
			wire stall;
			wire id_beq;
			initial begin
				strdata <= "01234567 00 0123f01d01e01m01w01 ";
				SW_old = 4'b0;
				clk_cnt <= 8'b0;
				cls <= 1'b0;
			end
			
			display M0 (CCLK, cls, strdata, rslcd, rwlcd, elcd, lcdd);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
			
			always @(posedge CCLK) begin
				if ((BTN3OUT == 1'b1) || (BTN2 == 1'b1)) begin
					//first line 8 4-bit Instrution
					strdata[255:248] <=  if_inst[31:28] < 10 ? 8'h30 + if_inst[31:28] : 55 + if_inst[31:28];
					strdata[247:240] <=  if_inst[27:24] < 10 ? 8'h30 + if_inst[27:24] : 55 + if_inst[27:24];
					strdata[239:232] <=  if_inst[23:20] < 10 ? 8'h30 + if_inst[23:20] : 55 + if_inst[23:20];
					strdata[231:224] <=  if_inst[19:16] < 10 ? 8'h30 + if_inst[19:16] : 55 + if_inst[19:16];
					strdata[223:216] <=  if_inst[15:12] < 10 ? 8'h30 + if_inst[15:12] : 55 + if_inst[15:12];
					strdata[215:208] <=  if_inst[11:8] < 10 ? 8'h30 + if_inst[11:8] : 55 + if_inst[11:8];
					strdata[207:200] <=  if_inst[7:4] < 10 ? 8'h30 + if_inst[7:4] : 55 + if_inst[7:4];
					strdata[199:192] <=  if_inst[3:0] < 10 ? 8'h30 + if_inst[3:0] : 55 + if_inst[3:0];
					//space
					//strdata[191:184] = " ";
					//2 4-bit CLK
					strdata[183:176] <=  clk_cnt[7:4] < 10 ? 8'h30 + clk_cnt[7:4] : 55 + clk_cnt[7:4];
					strdata[175:168] <=  clk_cnt[3:0] < 10 ? 8'h30 + clk_cnt[3:0] : 55 + clk_cnt[3:0];
					//space
					//strdata[167:160] = " ";

					//second line
					//strdata[127:120] = "f";
					strdata[119:112] <=  IF_ins_number < 10 ? 8'h30 + IF_ins_number : 55 + IF_ins_number;
					strdata[111:104] <=  IF_ins_type < 10 ? 8'h30 + IF_ins_type : 55 + IF_ins_type;
					//strdata[103:96] = "d";
					strdata[95:88] <=  ID_ins_number < 10 ? 8'h30 + ID_ins_number : 55 + ID_ins_number;
					strdata[87:80] <=  ID_ins_type < 10 ? 8'h30 + ID_ins_type : 55 + ID_ins_type;
					//strdata[79:72] = "e";
					strdata[71:64] <=  EX_ins_number < 10 ? 8'h30 + EX_ins_number : 55 + EX_ins_number;
					strdata[63:56] <=  EX_ins_type < 10 ? 8'h30 + EX_ins_type : 55 + EX_ins_type;
					//strdata[55:48] = "m";
					strdata[47:40] <=  MEM_ins_number < 10 ? 8'h30 + MEM_ins_number : 55 + MEM_ins_number;
					strdata[39:32] <=  MEM_ins_type < 10 ? 8'h30 + MEM_ins_type : 55 + MEM_ins_type;
					//strdata[31:24] = "w";
					strdata[23:16] <=  WB_ins_number < 10 ? 8'h30 + WB_ins_number : 55 + WB_ins_number;
					strdata[15:8] <=  WB_ins_type < 10 ? 8'h30 + WB_ins_type : 55 + WB_ins_type;
				end
				if((BTN3OUT == 1'b1) || (BTN2 == 1'b1)||(SW_old != SW)) begin
					//first line after CLK and space
					strdata[159:152] <= reg_content[15:12] < 10 ? 8'h30 + reg_content[15:12] : 55 + reg_content[15:12];
					strdata[151:144] <= reg_content[11:8] < 10 ? 8'h30 + reg_content[11:8] : 55 + reg_content[11:8];
					strdata[143:136] <= reg_content[7:4] < 10 ? 8'h30 + reg_content[7:4] : 55 + reg_content[7:4];
					strdata[135:128] <= reg_content[3:0] < 10 ? 8'h30 + reg_content[3:0] : 55 + reg_content[3:0];
					SW_old <= SW;
					cls <= 1;
				end
				else
					cls <= 0;
			end
			
			always @(posedge BTN3OUT or posedge rst) begin
				if(rst == 1'b1) begin
					clk_cnt <= 0;
				end
				else
					clk_cnt <= clk_cnt + 1;
			end

			assign pc [31:0] = if_npc[31:0];
			
		
			wire[31:0] id_beq_pc;
			/*anti_jitter x_anti_jitter(CCLK,
												rst,
												BTN3,
												BTN3OUT
												);
			*/
			if_stage x_if_stage(BTN3OUT, 
								rst, 
								pc, 
								//mem_pc, //the branch pc
								//mem_branch, //branch ctrl signal
								//ex_pc,
								id_beq_pc,
								//ex_branch,
								id_beq,
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

			id_stage x_id_stage(BTN3OUT, 
								rst, 
								if_inst, 
								if_pc4, 
								
								wb_destR, //write address
								wb_dest,		//write data
								wb_wreg,		//write enable
								id_wreg, 	//the instr whether write reg
								id_m2reg, 	//the instr whether write from mem to reg
								id_wmem, 	
								id_aluc, 
								id_shift, 
								id_aluimm, 
								id_branch, 
								id_inst,
								id_pc4, 
								id_inA, 
								id_inB, 
								id_imm, 
								id_regrt,
								id_rs,	//bypass adding 
								id_rt,
								id_rd, 
								
								ID_ins_type, 
								ID_ins_number, 
								EX_ins_type, 
								EX_ins_number, 
								{1'b0,which_reg}, 
								reg_content,
								
								aluR,
								destR,
								ex_aluR,
								ex_destR,
								id_beq,
								id_beq_pc
								);
				
			ex_stage x_ex_stage(BTN3OUT, 
								rst,
								id_imm, 
								id_inA_forward, 	//forward
								id_inB_forward, 	//forward
								id_wreg, 
								id_m2reg, 
								id_wmem, 
								id_aluc, 
								id_aluimm,
								id_shift, 
								id_branch, 
								id_pc4,
								id_regrt,
								id_rt,
								id_rd,
								
								ex_wreg, 
								ex_m2reg, 
								ex_wmem, 
								ex_aluR, 
								ex_inB, 
								ex_destR, 
								ex_branch, 
								ex_pc, 
								
								EX_ins_type, 
								EX_ins_number, 
								MEM_ins_type, 
								MEM_ins_number,
								
								aluR,
								destR
								);
			  
			mem_stage x_mem_stage(BTN3OUT,
								  rst,
								  ex_destR, 
								  ex_inB, 
								  ex_aluR, 
								  ex_wreg, 
								  ex_m2reg, 
								  ex_wmem, 
								  
								  mem_wreg, 
								  mem_m2reg, 
								  mem_mdata, 
								  mem_aluR, 
								  mem_destR, 
								  MEM_ins_type, 
								  MEM_ins_number, 
								  WB_ins_type, 
								  WB_ins_number
								  );

			wb_stage x_wb_stage(BTN3OUT,
								rst,
								mem_destR, 
								mem_aluR, 
								mem_mdata, 
								mem_wreg, 
								mem_m2reg,	  
								wb_wreg, //write enable
								wb_dest, //write data
								wb_destR, //write address
								WB_ins_type, 
								WB_ins_number,
								OUT_ins_type, 
								OUT_ins_number
								);
								
			forward_ctr x_forward_ctr(clk,
										 rst,
										 id_inA,
										 id_inB,										 
										 id_rs,
										 id_rt,
										 
										 ex_wreg,	//whether write into reg
										 ex_destR,	//destination register
										 ex_aluR,	
										 
										 wb_wreg,
										 wb_destR,
										 wb_dest,
										 
										 id_inA_forward,
										 id_inB_forward,
										 
										 inst,
										 if_inst,
										 stall
										 );
		endmodule
