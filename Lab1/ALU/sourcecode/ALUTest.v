`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:52:30 03/06/2016
// Design Name:   ALU
// Module Name:   E:/College Course/ThDSemester-2/Computer Architecture/Project/Lab1/ALU/ALU/sourcecode/ALUTest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALUTest;

	// Inputs
	reg CCLK;
	reg [2:0] SW;

	// Outputs
	wire LCDRS;
	wire LCDRW;
	wire LCDE;
	wire [3:0] LCDDAT;
	wire LED;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.CCLK(CCLK), 
		.SW(SW), 
		.LCDRS(LCDRS), 
		.LCDRW(LCDRW), 
		.LCDE(LCDE), 
		.LCDDAT(LCDDAT), 
		.LED(LED)
	);

	initial begin
		// Initialize Inputs
		CCLK = 0;
		SW = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		CCLK = 0;
		SW = 0;
		#100;
		
		CCLK = 0;
		SW = 1;
		#100;
		
		
	end
  
   initial begin
		forever
			CCLK = #10 ~CCLK;
	end
endmodule

