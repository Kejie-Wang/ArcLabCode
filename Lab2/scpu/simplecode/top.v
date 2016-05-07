`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:51:47 03/25/2016 
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
			  input wire BTN3, BTN2, 
			  input wire [3:0]SW, 
			  output wire LED, LCDE, LCDRS, LCDRW, 
			  output wire [3:0]LCDDAT
			  );
  
			wire [8:0] pc_out;
			wire [8:0] pc_in;
			wire [8:0] pc_plus_4;
			wire [4:0] reg3_out;
			wire [31:0] wdata_out;
			wire [31:0] instr_out;
			wire regwrite;
			wire alusrc;
			wire [1:0] aluop;
			wire memwrite;
			wire memtoreg;
			wire memread;
			wire branch;
			wire jump;
			wire regdst;
			wire [31:0] reg1_dat;
			wire [31:0] reg2_dat;
			wire [2:0] alu_ctrl; 
			wire [31:0] signext_out;
			wire [31:0] mux_to_alu;
			wire [31:0] alu_out;
			wire alu_zero;
			wire [31:0] mem_dat_out;
			wire and_out;
			wire [31:0] branch_addr_out;
			wire [31:0] branch_mux_out;
			wire [31:0] gpr_disp_out;
			
			reg [15:0] clk_cnt;
			reg [15:0] tmp_cnt;
			reg [1:0] disp_clk_cnt;

			reg [255:0] strdata;
			reg [3:0] SW_old;
			reg cls;

			wire [3:0] lcdd;
			wire rslcd, rwlcd, elcd;

			wire BTN3OUT;
			
			assign LCDDAT[3]=lcdd[3];
			assign LCDDAT[2]=lcdd[2];
			assign LCDDAT[1]=lcdd[1];
			assign LCDDAT[0]=lcdd[0];
			
			assign LCDRS=rslcd;
			assign LCDRW=rwlcd;
			assign LCDE=elcd;
			
			assign LED=BTN3;
		
			/*******************first line
			*0-7: instruction code
			*8: space
			*9-10: clock count
			*11: space
			*12-13: pc
			**********************second line
			*selected register content
			*/
			initial begin
				strdata = "01234567 00 00  0123            ";
			end
			
			display M0 (CCLK, cls, strdata, rslcd, rwlcd, elcd, lcdd);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    

			always @(posedge CCLK) begin
				if ((BTN3OUT == 1'b1) || (BTN2 == 1'b1)) begin
					//first line 8 4-bits Instrutions
					strdata[255:248] = instr_out[31:28] < 10 ? 8'h30 + instr_out[31:28] : 55 + instr_out[31:28];
					strdata[247:240] = instr_out[27:24] < 10 ? 8'h30 + instr_out[27:24] : 55 + instr_out[27:24];
					strdata[239:232] = instr_out[23:20] < 10 ? 8'h30 + instr_out[23:20] : 55 + instr_out[23:20];
					strdata[231:224] = instr_out[19:16] < 10 ? 8'h30 + instr_out[19:16] : 55 + instr_out[19:16];
					strdata[223:216] = instr_out[15:12] < 10 ? 8'h30 + instr_out[15:12] : 55 + instr_out[15:12];
					strdata[215:208] = instr_out[11:8] < 10 ? 8'h30 + instr_out[11:8] : 55 + instr_out[11:8];
					strdata[207:200] = instr_out[7:4] < 10 ? 8'h30 + instr_out[7:4] : 55 + instr_out[7:4];
					strdata[199:192] = instr_out[3:0] < 10 ? 8'h30 + instr_out[3:0] : 55 + instr_out[3:0];
					
					//space
					//strdata[191:184] = " ";
					
					//2 4-bit CLK
					strdata[183:176] = clk_cnt[7:4] < 10 ? 8'h30 + clk_cnt[7:4] : 55 + clk_cnt[7:4];
					strdata[175:168] = clk_cnt[3:0] < 10 ? 8'h30 + clk_cnt[3:0] : 55 + clk_cnt[3:0];
					
					//space
					//strdata[167:160] = " ";
					
					//2 4-bit PC
					strdata[159:152] = pc_out[7:4] < 10 ? 8'h30 + pc_out[7:4] : 55 + pc_out[7:4];
					strdata[151:144] = pc_out[3:0] < 10 ? 8'h30 + pc_out[3:0] : 55 + pc_out[3:0];
				end
				
				//second line
				//display the selected register content
				if((BTN3OUT == 1'b1) || (BTN2 == 1'b1) || (SW_old != SW)) begin
					strdata[127:120] = gpr_disp_out[15:12] < 10 ? 8'h30 + gpr_disp_out[15:12] : gpr_disp_out[15:12] + 55;
					strdata[119:112] = gpr_disp_out[11:8] < 10 ? 8'h30 + gpr_disp_out[11:8] : gpr_disp_out[11:8] + 55;
					strdata[111:104] = gpr_disp_out[7:4] < 10 ? 8'h30 + gpr_disp_out[7:4] : gpr_disp_out[7:4] + 55;
					strdata[103:96] = gpr_disp_out[3:0] < 10 ? 8'h30 + gpr_disp_out[3:0] : gpr_disp_out[3:0] + 55;
					SW_old = SW;
					cls = 1;
				end
				else
					cls = 0;
			end
			
			//button 2(south button): reset
			always @(posedge BTN3OUT or posedge BTN2) begin
				if (BTN2 == 1'b1) begin
					clk_cnt = 16'h0000;
				end
				else begin
					clk_cnt = clk_cnt + 1;
				end
			end

			always @(posedge CCLK or posedge BTN2) begin
			 if (BTN2==1) begin
					disp_clk_cnt=2'b00;
					tmp_cnt=0;
				 end
			  else begin
					tmp_cnt=tmp_cnt+1;
					if (tmp_cnt==16'h0000)
						disp_clk_cnt=disp_clk_cnt+1;
				end
			 end
				

			assign o_instr = instr_out[31:26];
			assign and_out = alu_zero & branch;
			assign pc_in = jump ? instr_out[8:0] : branch_mux_out[8:0];
			
			anti_jitter x_anti_jitter(CCLK,
												BTN2,
												BTN3,
												BTN3OUT
												);
			
			assign BTN3OUT = BTN3;
			single_pc 	x_single_pc(BTN3OUT,	//clk
											BTN2,	//reset
											pc_in,
											pc_out
											);
			
			c_instr_mem 	x_c_instr_mem(CCLK,
												  pc_out,
												  instr_out
												  );
			
			//pc_plus_4 = pc_out + 1
			single_pc_plus4 	x_single_pc_plus4(pc_out,
															pc_plus_4
															);
			
			/*@brief select the writing register
			*regdst as the select signal 0:rt, 1:rd
			*R-format: rd, regdst = 1
			*I-format: rt, regdst = 0
			*/
			single_mux5 	x_single_mux5(instr_out[20:16],	//rt
												  instr_out[15:11],	//rd
												  regdst,
												  reg3_out
												  );
			
			//
			single_gpr 	x_single_gpr(BTN2,
											 BTN3OUT,
											 instr_out[25:21],
											 instr_out[20:16],
											 {1'b0,SW},
											 reg3_out,
											 wdata_out,
											 regwrite,
											 reg1_dat,
											 reg2_dat,
											 gpr_disp_out
											 );
			
			//alu control
			single_aluc 	x_single_aluc(aluop,
												  instr_out[5:0],	//function field
												  alu_ctrl
												  );
			
			//signed extented
			single_signext 	x_single_signext(instr_out[15:0],
														  signext_out
														  );
														  
			single_mux32 	x_single_mux32(reg2_dat,
													signext_out,	//signed extend output
													alusrc,
													mux_to_alu
													);
													
			single_alu	 x_single_alu(reg1_dat,
											  mux_to_alu,
											  alu_ctrl,
											  alu_zero,
											  alu_out
											  );
											  
			c_dat_mem 	x_c_dat_mem(CCLK,	
											memwrite,
											alu_out[8:0],
											reg2_dat,
											mem_dat_out
											);
			
			/*0: alu_out
			*1: mem_dat_out 
			*/
			single_mux32 	x_single_mux32_2(alu_out,
													  mem_dat_out,
													  memtoreg,
													  wdata_out
													  );
													  
			single_add 	x_single_add(signext_out,
											{{23'b0},pc_plus_4},					
											branch_addr_out
											);
											
			single_mux32 	x_single_mux32_3({{23'b0}, pc_plus_4},	//pc_plus_4
													  branch_addr_out,	//
													  and_out,
													  branch_mux_out
													  );
			
			/*@brief single cpu control
			*@parameter instr_out The opcode
			*@parameter regdst The selected singnal which selects the written address(rt or rd)
			*@parameter jump The singnal which determintes whether jump(1: jump instr)
			*@parameter	branch The singnal which determintes whether branch(1: beq)
			*@parameter memread
			*@parameter memtoreg The singnal which determintes the data written into memory(0: alu, 1: mem(lw))
			*@parameter memwrite The written enable(sw = 1, other  = 0)
			*@parameter alusrc The singnal which determintes the ALUSRCB(0: reg, 1: signed extend)
			*@parameter regwrite The reg written enable
			*/
			single_ctl 	x_single_ctl(BTN2,
											 instr_out[31:26],
											 regdst,
											 jump,
											 branch,
											 memread,					
											 memtoreg,
											 aluop,
											 memwrite,
											 alusrc,
											 regwrite	
											 );	
endmodule

