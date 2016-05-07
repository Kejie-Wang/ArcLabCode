`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:57:46 03/07/2016 
// Design Name: 
// Module Name:    ALUC 
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

/*
*
*/

module ALUC(input CCLK, 
				input [1:0]BTN, 
				input [3:0] SW, 
				output LCDRS, LCDRW, LCDE, 
				output [3:0] LCDDAT, 
				output LED
				);
				
				wire [3:0]  lcdd;
				wire rslcd, rwlcd, elcd;
				wire 		   o_zf;
				wire [31:0] o_alu;
				wire [2:0]  i_aluc;
				wire [1:0]  alu_op;
				wire [3:0]  func;

				reg [31:0]  o_alu_old;

				reg [255:0] strdata;

				reg [31:0]  i_r;
				reg [31:0]  i_s;
				reg 		   rst;

				assign LCDDAT[3] = lcdd[3];
				assign LCDDAT[2] = lcdd[2];
				assign LCDDAT[1] = lcdd[1];
				assign LCDDAT[0] = lcdd[0];

				assign LCDRS = rslcd;
				assign LCDRW = rwlcd;
				assign LCDE = elcd;

				assign LED = o_zf;	//LED devotes the zero flag
				assign func[0] = SW[0];	//four swith devotes the function code
				assign func[1] = SW[1];
				assign func[2] = SW[2];
				assign func[3] = SW[3];
				assign alu_op[0] = BTN[0];	//two button devotes the alu operation
				assign alu_op[1] = BTN[1];

				initial begin
					strdata = "1111 2222                       ";
					i_r = 32'h1111;
					i_s = 32'h2222;
					rst = 0;
					o_alu_old = 0;
				end

				display M0 (CCLK, rst, strdata, rslcd, rwlcd, elcd, lcdd);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    

				single_alu M1(i_r, i_s, i_aluc, o_zf, o_alu);

				single_aluc M2(alu_op, func, i_aluc);

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

