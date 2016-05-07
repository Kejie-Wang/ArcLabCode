`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:49:06 03/12/2016
// Design Name:   Rtype
// Module Name:   E:/College Course/ThDSemester-2/Computer Architecture/Project/Lab1/RType/simplecode/Rtype_test.v
// Project Name:  Rtype
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Rtype
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module rtype_Test;
	reg	Clock,  Rst;
	reg[31:0]	Instr;

	parameter	ON_delay=80, OFF_delay=80;

	wire[31:0]	Adat, Bdat, Value;
	
	Rtype	Demo(Clock, Rst, Instr, Adat, Bdat, Value);
	
	always begin
		Clock =1;
		#ON_delay;
		Clock =0;
		#OFF_delay;
	end
	
	initial begin
		Rst=1;
		Instr=32'h01A88020;			//add $s0, $t5, $t0
		#160	Instr=32'h01C98822;	//sub $s1, $t6, $t1
		#160	Instr=32'h01EA9024;	//and $s2, $t7, $t2
		#160	Instr=32'h030B9825;	//or $s3, $k0, $t3
		#160	Instr=32'h032CA02A;	//slt $s4, $k1, $t4
		#1000	$dumpflush;
		$stop;
	end
endmodule
