`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:47 04/07/2016 
// Design Name: 
// Module Name:    mem_stage
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
module mem_stage (clk, rst, 
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
						
						EXE_ins_type, 
						EXE_ins_number, 
						MEM_ins_type, 
						MEM_ins_number
						);
  
			input clk, rst;
			input[4:0] ex_destR;
			input[31:0] ex_inB;
			input[31:0] ex_aluR;
			input ex_wreg;
			input ex_m2reg;
			input ex_wmem;
			
			input[3:0] EXE_ins_type;
			input[3:0]	EXE_ins_number;
			output[3:0] MEM_ins_type;
			output[3:0] MEM_ins_number;
			
			output mem_wreg;
			output mem_m2reg;
			output[31:0] mem_mdata;
			output[31:0] mem_aluR;
			output[4:0] mem_destR;
			
			reg mem_wreg; 
			reg mem_m2reg; 
			reg mem_aluR; 
			reg [31:0]mem_mdata;
			reg mem_destR;
			reg MEM_ins_type;
			reg MEM_ins_number;
			
			wire nclk = ~clk; 
			wire data;
			
			always@(posedge clk or posedge rst) begin
				if(rst) begin
					mem_wreg <= 0;
					mem_m2reg <= 0;
					mem_aluR <= 0;
					mem_mdata <= 0;
					mem_destR <= 0;
					MEM_ins_type <= 0;
					MEM_ins_number <= 0;
				end
				else begin
					mem_wreg <= ex_wreg;
					mem_m2reg <= ex_m2reg;
					mem_aluR <= ex_aluR;
					mem_mdata <= data;
					mem_destR <= ex_destR;
					MEM_ins_type <= EXE_ins_type;
					MEM_ins_number <= EXE_ins_number;
				end
			end
			
			data_mem x_data_mem(nclk,ex_wmem,ex_aluR[7:0],ex_inB,data);
	
endmodule
