`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:33:47 03/31/2016 
// Design Name: 
// Module Name:    anti_jitter 
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
module anti_jitter (
	input wire clk,  // main clock
	input wire rst,  // synchronous reset
	input wire sig_i,  // input signal with jitter noises
	output wire sig_o  // output signal without jitter noises
	);
	
	parameter
		CLK_FREQ = 100,  // main clock frequency in MHz
		JITTER_MAX = 10000;  // longest time for jitter noises in us
	parameter
		INIT_VALUE = 0;  // initialized output value
	localparam
		CLK_COUNT = CLK_FREQ * JITTER_MAX;  // CLK_FREQ * 1000000 / (1000000 / JITTER_MAX)
	
	reg [31:0] clk_count = 0;
	reg buff = INIT_VALUE;
	
	always @(posedge clk) begin
		if (rst) begin
			clk_count <= 0;
			buff <= INIT_VALUE;
		end
		else if (sig_i == sig_o) begin
			clk_count <= 0;
		end
		else if (clk_count == CLK_COUNT-1) begin
			clk_count <= 0;
			buff <= sig_i;
		end
		else begin
			clk_count <= clk_count + 1'h1;
		end
	end
	
	assign sig_o = buff;
	
endmodule
