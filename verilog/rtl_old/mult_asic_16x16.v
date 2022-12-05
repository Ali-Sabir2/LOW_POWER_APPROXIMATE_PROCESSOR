`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 

// Create Date: 02/11/2022 10:59:41 AM
// Design Name: 
// Module Name: mult_asic_8x8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mult_asic_16x16(
input [15:0] a,b,
output [31:0] P
);

wire [17:0] PS_r1,PS_r2,PS_r3,PS_r4,PS_r5,PS_r6,PS_r7,PS_r8;

PS_R1 PS_R1_inst1 (.a(a),.b(b[1:0]),.PS(PS_r1));
PS_Rx PS_Rx_inst2 (.a(a),.b(b[3:1]),.x(PS_r1[17:2]),.PS(PS_r2));
PS_Rx PS_Rx_inst3 (.a(a),.b(b[5:3]),.x(PS_r2[17:2]),.PS(PS_r3));
PS_Rx PS_Rx_inst4 (.a(a),.b(b[7:5]),.x(PS_r3[17:2]),.PS(PS_r4));
PS_Rx PS_Rx_inst5 (.a(a),.b(b[9:7]),.x(PS_r4[17:2]),.PS(PS_r5));
PS_Rx PS_Rx_inst6 (.a(a),.b(b[11:9]),.x(PS_r5[17:2]),.PS(PS_r6));
PS_Rx PS_Rx_inst7 (.a(a),.b(b[13:11]),.x(PS_r6[17:2]),.PS(PS_r7));
PS_Rx PS_Rx_inst8 (.a(a),.b(b[15:13]),.x(PS_r7[17:2]),.PS(PS_r8));
assign P[0] = a[0];
assign P[2:1] = PS_r1[1:0];
assign P[4:3] = PS_r2[1:0];
assign P[6:5] = PS_r3[1:0];
assign P[8:7] = PS_r4[1:0];
assign P[10:9] = PS_r5[1:0];
assign P[12:11] = PS_r6[1:0];
assign P[14:13] = PS_r7[1:0];
assign P[31:15] = PS_r8[17:0];

endmodule
