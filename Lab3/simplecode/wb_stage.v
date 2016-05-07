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

		
		reg [3:0] WB_ins_type;
		reg [3:0] WB_ins_number;
		
		reg  wb_wreg;
		reg [4:0] wb_destR;
		reg [31:0] wb_dest;
	
		always@(posedge clk or posedge rst)	begin
			if(rst) begin
				wb_wreg <= 0;
				wb_dest <= 0;
				wb_destR <= 0;
				WB_ins_type <= 0;
				WB_ins_number <= 0;
			end
			else begin
				wb_wreg <= mem_wreg;
				wb_dest <= mem_m2reg ? mem_mdata : mem_aluR;
				wb_destR <= mem_destR;
				WB_ins_type <= MEM_ins_type;
				WB_ins_number <= MEM_ins_number;
			end
	end

endmodule
