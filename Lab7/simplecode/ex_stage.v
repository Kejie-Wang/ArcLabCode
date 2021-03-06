`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:47 04/07/2016 
// Design Name: 
// Module Name:   ex_stage
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
module ex_stage (clk, 
					  rst,
					  
					  id_imm, //instruction decode immediate
					  id_inA, 
					  id_inB, 				  
					  id_wreg, 
					  id_m2reg, 
					  id_wmem, 
					  id_aluc, 
					  id_aluimm,
					  id_shift, 
					  id_branch, 
					  
					  id_lui,
					  id_jr,
					  id_jal,
					  
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
					  
					  ID_ins_type, 
					  ID_ins_number, 
					  EXE_ins_type, 
					  EXE_ins_number,
					  
					  aluR,
					  destR
					  );
					  
			input clk, rst;
			input[31:0] id_imm;
			input[31:0] id_inA;
			input[31:0] id_inB;
			input id_wreg;
			input id_m2reg;
			input id_wmem;
			input[3:0] id_aluc;
			input id_aluimm;
			input id_shift;
			input id_regrt;
			input[4:0] id_rt;
			input[4:0] id_rd;
			
			input[3:0] ID_ins_type;
			input[3:0] ID_ins_number;
			output reg [3:0] EXE_ins_type;
			output reg [3:0] EXE_ins_number;
			
			output [31:0]aluR;
			output [4:0]destR;
			
			input[31:0] id_pc4;
			input id_branch;
			input id_lui;
			input id_jr;
			input id_jal;
			output reg ex_wreg;
			output reg ex_m2reg;
			output reg ex_wmem;
			output reg [31:0] ex_aluR;
			output reg [31:0] ex_inB;			
			output reg [4:0] ex_destR;
			output reg ex_branch;
			output reg [31:0] ex_pc;
			
			wire zero;
			wire [31:0] sa;
		
			wire [31:0]a_in;
			wire [31:0]b_in;
			wire [31:0]aluR;
			assign a_in = id_shift ? sa : id_inA;
			assign b_in = id_aluimm ? id_imm : id_inB;
			assign zero = ~(|aluR);			//zero flag	
			
			assign destR = id_regrt? id_rt : id_rd;
			
			always@(posedge clk or posedge rst) begin		
				if(rst == 1'b1) begin
					ex_wreg <= 1'b0;
					ex_m2reg <= 1'b0;
					ex_wmem <= 1'b0;
					ex_aluR <= 32'b0;
					ex_inB <= 32'b0;
					ex_destR <= 5'b0;
					ex_branch<= 1'b0;
					ex_pc <= 32'b0;
					EXE_ins_type <= 4'b0;
					EXE_ins_number <= 4'b0;
				end
				else begin
					ex_wreg <= id_wreg;
					ex_m2reg <= id_m2reg;
					ex_wmem <= id_wmem;					
					ex_inB <= id_inB;
					ex_aluR <= id_jal ? id_pc4 : (id_lui ? id_imm << 16 : aluR);
					ex_destR <= id_jal ? 31 : (id_regrt? id_rt : id_rd); //the write back destination reg
					ex_branch<=id_branch & zero;
					ex_pc <= id_pc4 + id_imm; //{odata_imm[29:0], 2'b00};
					EXE_ins_type <= ID_ins_type;
					EXE_ins_number <= ID_ins_number;
				end
			end
			
			//sa: shamt
			imm2sa x_imm2sa(id_imm,
								 sa
								 );
			
			Alu x_Alu(a_in,
						 b_in,
						 id_aluc,
						 aluR
						 );
	
endmodule
