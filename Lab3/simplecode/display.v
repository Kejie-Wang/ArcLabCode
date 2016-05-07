`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:14:56 03/05/2016 
// Design Name: 
// Module Name:    display 
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
module display(input CCLK, reset,
					input [255:0]strdata, 
					output rslcd, rwlcd, elcd, 
					output [3:0] lcdd
					);

	wire [7:0] lcddatin;
					
	lcd M0 (CCLK, 
			  resetlcd, 
			  clearlcd, 
			  homelcd, 
			  datalcd, 
			  addrlcd,
			  lcdreset, 
			  lcdclear, 
			  lcdhome, 
			  lcddata, 
			  lcdaddr,
			  rslcd, 
			  rwlcd, 
			  elcd, 
			  lcdd, 
			  lcddatin, 
			  initlcd
			  );
				
	genlcd M1 (CCLK, 
				  reset, 
				  strdata, 
				  resetlcd, 
				  clearlcd, 
				  homelcd, 
				  datalcd,
				  addrlcd, 
				  initlcd, 
				  lcdreset, 
				  lcdclear, 
				  lcdhome,
				  lcddata, 
				  lcdaddr, 
				  lcddatin
				  );                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        				
endmodule





