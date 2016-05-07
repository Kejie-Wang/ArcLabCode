`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:00:37 03/07/2016
// Design Name:   single_alu
// Module Name:   E:/College Course/ThDSemester-2/Computer Architecture/Project/Lab1/ALU/ALU/sourcecode/single_alu_test.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: single_alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module single_alu_test;

	// Inputs
	reg [31:0] i_r;
	reg [31:0] i_s;
	reg [2:0] i_aluc;

	// Outputs
	wire o_zf;
	wire [31:0] o_alu;

	// Instantiate the Unit Under Test (UUT)
	single_alu uut (
		.i_r(i_r), 
		.i_s(i_s), 
		.i_aluc(i_aluc), 
		.o_zf(o_zf), 
		.o_alu(o_alu)
	);

	initial begin
		// Initialize Inputs
		i_r = 0;
		i_s = 0;
		i_aluc = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		i_r = 32'h1234;
		i_s = 32'h5678;
		i_aluc = 0;
		#100;
		
		i_r = 32'h1234;
		i_s = 32'h5678;
		i_aluc = 1;
		#100;
		
		i_r = 32'h1234;
		i_s = 32'h5678;
		i_aluc = 2;
		#100;
		
		i_r = 32'h1234;
		i_s = 32'h5678;
		i_aluc = 3;
		#100;
		
		i_r = 32'h1234;
		i_s = 32'h5678;
		i_aluc = 4;
		#100;
		
		i_r = 32'h1234;
		i_s = 32'h5678;
		i_aluc = 5;
		#100;
		
		i_r = 32'h1234;
		i_s = 32'h5678;
		i_aluc = 6;
		#100;
		
		i_r = 32'h1234;
		i_s = 32'h5678;
		i_aluc = 7;
		#100;
		
		#100;
	end
      
endmodule

