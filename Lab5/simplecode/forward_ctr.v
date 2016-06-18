`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:37 05/07/2016 
// Design Name: 
// Module Name:    stall_ctr 
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
//macro.vh
//macro definitions

//operation code
module forward_ctr(clk,
						rst,
						id_inA,
						id_inB,
						
						id_rs,
						id_rt,
						
						mem_wreg,
						mem_destR,
						mem_aluR,
						
						wb_wreg,
						wb_destR,
						wb_dest,
						
						id_inA_forward,
						id_inB_forward,
						
						inst,
						if_inst,
						stall
						);
		
		input rst, clk;
		input [31:0]inst;
		input [31:0]if_inst;
		input [31:0]id_inA;
		input [31:0]id_inB;
		input [4:0]id_rs;
		input [4:0]id_rt;
		input mem_wreg;
		input [4:0]mem_destR;
		input [31:0]mem_aluR;
		input wb_wreg;
		input [4:0]wb_destR;
		input [31:0]wb_dest;
		
		output [31:0]id_inA_forward;
		output [31:0]id_inB_forward;
		output reg stall;
		
		wire [4:0]rs;
		wire [4:0]rt;
		wire [5:0]if_op;
		wire [4:0]if_rt;
		
		assign rs = inst[25:21];
		assign rt = inst[20:16];
		assign if_op = if_inst[31:26];
		assign if_rt = if_inst[20:16];

		wire wb_rs_forward, wb_rt_forward, mem_rs_forward, mem_rt_forward;
		assign mem_rs_forward = (mem_wreg && (mem_destR != 0) && (mem_destR == id_rs));
		assign mem_rt_forward = (mem_wreg && (mem_destR != 0) && (mem_destR == id_rt));
		assign wb_rs_forward = (wb_wreg && (wb_destR != 0) && (wb_destR == id_rs));
		assign wb_rt_forward = (wb_wreg && (wb_destR != 0) && (wb_destR == id_rt));
		
		assign id_inA_forward = (mem_rs_forward) ? mem_aluR : ((wb_rs_forward) ? wb_dest : id_inA);
		assign id_inB_forward = (mem_rt_forward) ? mem_aluR : ((wb_rt_forward) ? wb_dest : id_inB);
	
		always @(*) begin
			if(rst)
				stall <=0;
			else
				stall <= ((if_op == 6'b100011) && ((if_rt == rs) || (if_rt == rt))) ? 1 : 0;
		end
		
endmodule
