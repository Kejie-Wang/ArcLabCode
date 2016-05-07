`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:47 04/07/2016 
// Design Name: 
// Module Name:    regfile
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
module regfile(clk, 
					rst, 
					raddr_A, 
					raddr_B, 
					waddr, 
					wdata, 
					we, 
					rdata_A, 
					rdata_B,	
					which_reg, 
					reg_content
					);           
	input clk;
	input rst;
	input [4:0] raddr_A;
	input [4:0] raddr_B;
	input [4:0] waddr;
	input [31:0] wdata;
	input we;
	output [31:0] rdata_A;
	output [31:0] rdata_B;
	
	input [4:0] which_reg;
	output [31:0] reg_content;
	
	wire clk;
	wire rst;
	wire [4:0] raddr_A;
	wire [4:0] raddr_B;
	wire [31:0] wdata;
	wire we;
	wire [31:0] rdata_A;
	wire [31:0] rdata_B;
	wire [31:0] reg_content;
	
	reg [31:0]regs[0:31];

	integer i;
	always @ (negedge clk or posedge rst) begin		
		if (rst == 1) begin		//reset is triggered
			for(i=0;i<32;i=i+1)
				regs[i] <= 0;
		end
		else if (we == 1) begin		//write register when we is high level
			regs[waddr] <= (waddr==0) ? 0:wdata;
		end
	end

	assign rdata_A = (raddr_A == 0) ? 0 : regs[raddr_A];
	assign rdata_B = (raddr_B == 0) ? 0 : regs[raddr_B];
	assign reg_content = (which_reg == 0) ? 0 : regs[which_reg];

	endmodule 
