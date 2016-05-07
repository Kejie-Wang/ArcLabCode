`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:31:59 03/25/2016 
// Design Name: 
// Module Name:    single_gpr 
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
module single_gpr(
    rst,//reset
    clk,//clock
    i_adr1,//register index 1
    i_adr2,//register index 2
    i_adr3,//register index 3
    i_wreg,//register to write
    i_wdata,//data to write
    i_wen,//write enable
    o_op1,//read data1, out
    o_op2,//read data2, out
    o_op3//read data3, out
);
                             
	 input clk;
	 input rst;                
	 input [4:0] i_adr1; 
	 input [4:0] i_adr2;
	 input [4:0] i_adr3;
	 input [31:0] i_wdata;
	 input [4:0] i_wreg;
	 input i_wen;
	 output [31:0] o_op1;
	 output [31:0] o_op2;
	 output [31:0] o_op3;
	 reg [31:0] mem[31:0];
	 
		assign o_op1 = i_adr1==0 ? 0 : mem[i_adr1];
		assign o_op2 = i_adr2==0 ? 0 : mem[i_adr2];
		assign o_op3 = i_adr3==0 ? 0 : mem[i_adr3];
	 always @(posedge clk or posedge rst) begin
		if (rst == 1) begin
			  mem[0] <= 32'h00000000;
			  mem[1] <= 32'h00000000;
			  mem[2] <= 32'h00000000;
			  mem[3] <= 32'h00000000;
			  mem[4] <= 32'h00000000;
		end
		else if (i_wen) begin
			mem[i_wreg] <= (i_wreg == 5'b00000) ? 32'h00000000 : i_wdata;
		end
	 end
endmodule
