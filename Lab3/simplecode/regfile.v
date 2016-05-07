`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:47 04/07/2016 
// Design Name: 
// Module Name:    regfile
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
module regfile(clk, 
					rst, 
					raddr_A, 
					raddr_B, 
					waddr, 
					wdata, 
					we, 
					rdata_A, 
					rdata_B,	
					which_reg, 
					reg_content
					);           
	input clk;
	input rst;
	input [4:0] raddr_A;
	input [4:0] raddr_B;
	input [4:0] waddr;
	input [31:0] wdata;
	input we;
	output [31:0] rdata_A;
	output [31:0] rdata_B;
	
	input [4:0] which_reg;
	output [31:0] reg_content;
	
	wire clk;
	wire rst;
	wire [4:0] raddr_A;
	wire [4:0] raddr_B;
	wire [31:0] wdata;
	wire we;
	wire [31:0] rdata_A;
	wire [31:0] rdata_B;
	wire [31:0] reg_content;
	
	reg [31:0] regs[0:31];

	integer i;
	always @ (negedge clk or posedge rst) begin		
		if (rst == 1) begin		//reset is triggered
			for(i=0;i<32;i=i+1)
				regs[i] <= 0;
		end
		else if (we == 1) begin		//write register when we is high level
			regs[waddr] <= (waddr==0) ? 0:wdata;
		end
	end

	assign rdata_A = (raddr_A == 0) ? 0 : regs[raddr_A];
	assign rdata_B = (raddr_B == 0) ? 0 : regs[raddr_B];
	assign reg_content = (which_reg == 0) ? 0 : regs[which_reg];
	
	//read when clk is low level
	/*always @ (clk) begin		//when clk is changed
		if	(clk == 0) begin				//when clk is low level
		  case(raddr_A)
				5'b00000: rdata_A <= r0;
				5'b00001: rdata_A <= r1;
				5'b00010: rdata_A <= r2;
				5'b00011: rdata_A <= r3;
				5'b00100: rdata_A <= r4;
				5'b00101: rdata_A <= r5;
				5'b00110: rdata_A <= r6;
				5'b00111: rdata_A <= r7;
				5'b01000: rdata_A <= r8;
				5'b01001: rdata_A <= r9;
				5'b01010: rdata_A <= r10;
				5'b01011: rdata_A <= r11;
				5'b01100: rdata_A <= r12;
				5'b01101: rdata_A <= r13;
				5'b01110: rdata_A <= r14;
				5'b01111: rdata_A <= r15;
				default:  rdata_A <= r0;
			 endcase 
			 
			 case(raddr_B)
				5'b00000: rdata_B <= r0;
				5'b00001: rdata_B <= r1;
				5'b00010: rdata_B <= r2;
				5'b00011: rdata_B <= r3;
				5'b00100: rdata_B <= r4;
				5'b00101: rdata_B <= r5;
				5'b00110: rdata_B <= r6;
				5'b00111: rdata_B <= r7;
				5'b01000: rdata_B <= r8;
				5'b01001: rdata_B <= r9;
				5'b01010: rdata_B <= r10;
				5'b01011: rdata_B <= r11;
				5'b01100: rdata_B <= r12;
				5'b01101: rdata_B <= r13;
				5'b01110: rdata_B <= r14;
				5'b01111: rdata_B <= r15;
				default:  rdata_B <= r0;
			 endcase
		 end
	end

	always @ (clk or which_reg) //when clk or which_reg is changed
		begin
			case(which_reg)
				5'b00000: reg_content <= r0;
				5'b00001: reg_content <= r1;
				5'b00010: reg_content <= r2;
				5'b00011: reg_content <= r3;
				5'b00100: reg_content <= r4;
				5'b00101: reg_content <= r5;
				5'b00110: reg_content <= r6;
				5'b00111: reg_content <= r7;
				5'b01000: reg_content <= r8;
				5'b01001: reg_content <= r9;
				5'b01010: reg_content <= r10;
				5'b01011: reg_content <= r11;
				5'b01100: reg_content <= r12;
				5'b01101: reg_content <= r13;
				5'b01110: reg_content <= r14;
				5'b01111: reg_content <= r15;
				default:  reg_content <= r0;
			endcase
		end
		*/
	endmodule 
