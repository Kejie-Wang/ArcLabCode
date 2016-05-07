`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:30:55 03/07/2016 
// Design Name: 
// Module Name:    RegFile 
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
`define ALUC_CTL_AND		3'b000
`define ALUC_CTL_OR		3'b001
`define ALUC_CTL_ADD		3'b010
`define ALUC_CTL_SUB		3'b110
`define ALUC_CTL_SLT		3'b111
`define RTYPE_ADD		4'b0000
`define RTYPE_SUB		4'b0010
`define RTYPE_SLT		4'b1010
`define RTYPE_AND		4'b0100
`define RTYPE_OR		4'b0101
`define RTYPE_XOR		4'b0110
`define RTYPE_NOR		4'b0111
`define RTYPE_ADDU		4'b0001
`define RTYPE_SLTU		4'b1011

module RegFile(rst, clk, regA, regB, regW, Wdat, Adat, Bdat, RegWrite);
    input rst, clk;
	 input [4:0] regA;
    input [4:0] regB;
    input [4:0] regW;
    input [31:0] Wdat;
    input RegWrite;
	 
    output [31:0] Adat, Bdat;
    reg [31:0] Adat, Bdat;

	reg[31:0]	Szero, Sat, Sa0, Sa1, Sv0, Sv1, Sv2, Sv3;	//0
	reg[31:0]	St0, St1, St2, St3, St4, St5, St6, St7;	//8
	reg[31:0]	Ss0, Ss1, Ss2, Ss3, Ss4, Ss5, Ss6, Ss7;	//16
	reg[31:0]	St8, St9, Sk0, Sk1, Sgp, Sfp, Ssp, Sra;	//24

	initial begin
		Szero = 0;	//¼Ä´æÆ÷×é
		Sat = 1;
		Sa0 = 2;
		Sa1 = 3;
		Sv0 = 4;
		Sv1 = 5;
		Sv2 = 6;
		Sv3 = 7;
		St0 = 8;
		St1 = 9;
		St2 = 10;
		St3 = 11;
		St4 = 12;
		St5 = 13;
		St6 = 14;
		St7 = 15;
		Ss0 = 16;
		Ss1 = 17;
		Ss2 = 18;
		Ss3 = 19;
		Ss4 = 20;
		Ss5 = 21;
		Ss6 = 22;
		Ss7 = 23;
		St8 = 24;
		St9 = 25;
		Sk0 = 26;
		Sk1 = 27;
		Sgp = 28;
		Sfp = 29;
		Ssp = 30;
		Sra = 31;
	end
	always @ (posedge clk)begin
		case(regA)
			0:  Adat = Szero;
			1:  Adat = Sat;
			2:  Adat = Sa0;
			3:  Adat = Sa1;
			4:  Adat = Sv0;
			5:  Adat = Sv1;
			6:  Adat = Sv2;
			7:  Adat = Sv3;
			8:  Adat = St0;
			9:  Adat = St1;
			10: Adat = St2;
			11: Adat = St3;
			12: Adat = St4;
			13: Adat = St5;
			14: Adat = St6;
			15: Adat = St7;
			16: Adat = Ss0;
			17: Adat = Ss1;
			18: Adat = Ss2;
			19: Adat = Ss3;
			20: Adat = Ss4;
			21: Adat = Ss5;
			22: Adat = Ss6;
			23: Adat = Ss7;
			24: Adat = St8;
			25: Adat = St9;
			26: Adat = Sk0;
			27: Adat = Sk1;
			28: Adat = Sgp;
			29: Adat = Sfp;
			30: Adat = Ssp;
			31: Adat = Sra;
		endcase
		case(regB)
			0:  Bdat = Szero;
			1:  Bdat = Sat;
			2:  Bdat = Sa0;
			3:  Bdat = Sa1;
			4:  Bdat = Sv0;
			5:  Bdat = Sv1;
			6:  Bdat = Sv2;
			7:  Bdat = Sv3;
			8:  Bdat = St0;
			9:  Bdat = St1;
			10: Bdat = St2;
			11: Bdat = St3;
			12: Bdat = St4;
			13: Bdat = St5;
			14: Bdat = St6;
			15: Bdat = St7;
			16: Bdat = Ss0;
			17: Bdat = Ss1;
			18: Bdat = Ss2;
			19: Bdat = Ss3;
			20: Bdat = Ss4;
			21: Bdat = Ss5;
			22: Bdat = Ss6;
			23: Bdat = Ss7;
			24: Bdat = St8;
			25: Bdat = St9;
			26: Bdat = Sk0;
			27: Bdat = Sk1;
			28: Bdat = Sgp;
			29: Bdat = Sfp;
			30: Bdat = Ssp;
			31: Bdat = Sra;
		endcase
	end
	always @ (negedge clk)begin
		if(RegWrite==1)
		case(regW)
			//0:  Szero = Wdat; //$zero can't be written
			1:  Sat = Wdat;
			2:  Sa0 = Wdat;
			3:  Sa1 = Wdat;
			4:  Sv0 = Wdat;
			5:  Sv1 = Wdat;
			6:  Sv2 = Wdat;
			7:  Sv3 = Wdat;
			8:  St0 = Wdat;
			9:  St1 = Wdat;
			10: St2 = Wdat;
			11: St3 = Wdat;
			12: St4 = Wdat;
			13: St5 = Wdat;
			14: St6 = Wdat;
			15: St7 = Wdat;
			16: Ss0 = Wdat;
			17: Ss1 = Wdat;
			18: Ss2 = Wdat;
			19: Ss3 = Wdat;
			20: Ss4 = Wdat;
			21: Ss5 = Wdat;
			22: Ss6 = Wdat;
			23: Ss7 = Wdat;
			24: St8 = Wdat;
			25: St9 = Wdat;
			26: Sk0 = Wdat;
			27: Sk1 = Wdat;
			28: Sgp = Wdat;
			29: Sfp = Wdat;
			30: Ssp = Wdat;
			31: Sra = Wdat;
		endcase
	end
endmodule
