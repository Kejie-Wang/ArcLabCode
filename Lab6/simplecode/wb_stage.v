`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:47 04/07/2016 
// Design Name: 
// Module Name:    wb_stage
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
module wb_stage(clk, rst, 
					 mem_destR, 
					 mem_aluR, 
					 mem_mdata, 
					 mem_wreg, 
					 mem_m2reg, 
					 
					 wb_wreg, 				
					 wb_dest, 
					 wb_destR, 
					 
					 MEM_ins_type, 
					 MEM_ins_number, 
					 WB_ins_type, 
					 WB_ins_number
					 );
		input clk, rst;
		input[4:0] mem_destR;
		input[31:0] mem_aluR;
		input[31:0] mem_mdata;
		input mem_wreg;
		input mem_m2reg;
		
		input[3:0] MEM_ins_type;
		input[3:0]	MEM_ins_number;
		output[3:0] WB_ins_type;
		output[3:0] WB_ins_number;
		
		output wb_wreg;
		output[4:0] wb_destR;
		output[31:0] wb_dest;

		assign wb_wreg = mem_wreg;
		assign wb_dest = mem_m2reg ? mem_mdata : mem_aluR;
		assign wb_destR = mem_destR;
		assign WB_ins_type = MEM_ins_type;
		assign WB_ins_number = MEM_ins_number;
		
endmodule