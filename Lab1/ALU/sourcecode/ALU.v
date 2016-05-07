`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:48:39 03/05/2016 
// Design Name: 
// Module Name:    ALU 
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
/*@brief This is the alu module
*@parameter CCLK	The clock
*@parameter SW 		The switch(the operation code)
*@parameter LCDRS
*@parameter LCDRW
*@parameter LCDE
*@parameter LCDDAT	The lcd data output
*@parameter LED 		The led data output(zero flag)
*/
module ALU(input CCLK, 
			  input [2:0] SW, 
			  output LCDRS, LCDRW, LCDE, 
			  output [3:0] LCDDAT, 
			  output LED
			  );
	wire [3:0] lcdd;
	wire rslcd, rwlcd, elcd;
	wire o_zf;
	wire [31:0] o_alu;
	wire [2:0] i_aluc;

	reg [31:0] o_alu_old;
	reg [255:0]strdata;

	reg [31:0] i_r;
	reg [31:0] i_s;
	reg rst;

	assign LCDDAT[3]=lcdd[3];
	assign LCDDAT[2]=lcdd[2];
	assign LCDDAT[1]=lcdd[1];
	assign LCDDAT[0]=lcdd[0];

	assign LCDRS=rslcd;
	assign LCDRW=rwlcd;
	assign LCDE=elcd;

	//LED devotes the zero flag
	//switch 0-2 devotes the operation code
	assign LED = o_zf;
	assign i_aluc[0] = SW[0];
	assign i_aluc[1] = SW[1];
	assign i_aluc[2] = SW[2];

	initial begin
		strdata = "1111 2222                       ";
		i_r = 32'h1111;
		i_s = 32'h2222;
		rst = 0;
		o_alu_old = 0;
	end

	display M0 (CCLK, rst, strdata, rslcd, rwlcd, elcd, lcdd);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    

	single_alu M1(i_r, i_s, i_aluc, o_zf, o_alu);

	always @(posedge CCLK) begin
		if (o_alu_old != o_alu) begin
			if(o_alu[15:12] < 10)
				strdata[127:120] = 8'h30 + o_alu[15:12];
			else
				strdata[127:120] = 55 + o_alu[15:12];
			if(o_alu[11:8] < 10)
				strdata[119:112] = 8'h30 + o_alu[11:8];
			else
				strdata[119:112] = 55 + o_alu[11:8];
			if(o_alu[7:4] < 10)
				strdata[111:104] = 8'h30 + o_alu[7:4];
			else
				strdata[111:104] = 55 + o_alu[7:4];
			if(o_alu[3:0] < 10)
				strdata[103:96] = 8'h30 + o_alu[3:0];
			else
				strdata[103:96] = 55 + o_alu[3:0];
			rst = 1;
			o_alu_old = o_alu;
		end
		else
			rst = 0;
	end
endmodule
