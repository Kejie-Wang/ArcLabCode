`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:28:19 04/13/2016
// Design Name:   top
// Module Name:   E:/College Course/ThDSemester-2/Computer Architecture/Project/Lab3/simplecode/top_test.v
// Project Name:  Lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_test;

	// Inputs
	reg CCLK;
	reg BTN3;
	reg BTN2;
	reg [3:0] SW;

	// Outputs
	wire LED;
	wire LCDE;
	wire LCDRS;
	wire LCDRW;
	wire [3:0] LCDDAT;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.CCLK(CCLK), 
		.BTN3(BTN3), 
		.BTN2(BTN2), 
		.SW(SW), 
		.LED(LED), 
		.LCDE(LCDE), 
		.LCDRS(LCDRS), 
		.LCDRW(LCDRW), 
		.LCDDAT(LCDDAT)
	);

	initial begin
		// Initialize Inputs
		CCLK = 0;
		BTN3 = 0;
		BTN2 = 1;
		SW = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		BTN3 = 1;
		BTN2 = 0;
		SW = 4'b0010;  
		#500;
		
		#200;
		BTN2 = 1;
		SW = 4'b0001;  
		#50;
		
		BTN3 = 1;
		BTN2 = 0;
		SW = 4'b0010;  
		#500;

	end
	
   initial forever #10 CCLK = ~CCLK;
	initial forever #50 BTN3 = ~BTN3;
   
endmodule

