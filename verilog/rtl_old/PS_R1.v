`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 11:28:07 AM
// Design Name: 
// Module Name: PS_R1
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


module PS_R1(
input [15:0] a,
input [1:0] b,
output [17:0] PS
    );
    
wire [15:0] O5;
wire [15:0] CO;


 // PS and C0 of LUT type-T   
 LUT_1RT LUT_inst1 (b[1],b[0],1'b0,a[1],a[0],O5[0]);
 carry_1R  carry_inst (O5[0],b[1],PS[0],CO[0]);
 
 // PS and C0 of LUT type-N
 LUT_1RN LUT_inst2 (b[1],b[0],1'b0,a[2],a[1],O5[1]);
 carry_1R  carry_inst2 (O5[1],CO[0],PS[1],CO[1]);
 
 LUT_1RN LUT_inst3 (b[1],b[0],1'b0,a[3],a[2],O5[2]);
 carry_1R  carry_inst3 (O5[2],CO[1],PS[2],CO[2]);
 
 LUT_1RN LUT_inst4 (b[1],b[0],1'b0,a[4],a[3],O5[3]);
 carry_1R  carry_inst4 (O5[3],CO[2],PS[3],CO[3]);
 
 LUT_1RN LUT_inst5 (b[1],b[0],1'b0,a[5],a[4],O5[4]);
 carry_1R  carry_inst5 (O5[4],CO[3],PS[4],CO[4]);
 
 LUT_1RN LUT_inst6 (b[1],b[0],1'b0,a[6],a[5],O5[5]);
 carry_1R  carry_inst6 (O5[5],CO[4],PS[5],CO[5]);
 
 LUT_1RN LUT_inst7 (b[1],b[0],1'b0,a[7],a[6],O5[6]);
 carry_1R  carry_inst7 (O5[6],CO[5],PS[6],CO[6]);
 
 LUT_1RN LUT_inst8 (b[1],b[0],1'b0,a[8],a[7],O5[7]);
 carry_1R  carry_inst78 (O5[7],CO[6],PS[7],CO[7]);
 
 LUT_1RN LUT_inst9 (b[1],b[0],1'b0,a[9],a[8],O5[8]);
 carry_1R  carry_inst9 (O5[8],CO[7],PS[8],CO[8]);
 
 LUT_1RN LUT_inst10 (b[1],b[0],1'b0,a[10],a[9],O5[9]);
 carry_1R  carry_inst10 (O5[9],CO[8],PS[9],CO[9]);
 
 LUT_1RN LUT_inst11 (b[1],b[0],1'b0,a[11],a[10],O5[10]);
 carry_1R  carry_inst11 (O5[10],CO[9],PS[10],CO[10]);
 
  
 LUT_1RN LUT_inst12 (b[1],b[0],1'b0,a[12],a[11],O5[11]);
 carry_1R  carry_inst12 (O5[11],CO[10],PS[11],CO[11]);
  
 LUT_1RN LUT_inst13 (b[1],b[0],1'b0,a[13],a[12],O5[12]);
 carry_1R  carry_inst13 (O5[12],CO[11],PS[12],CO[12]);
 
  LUT_1RN LUT_inst14 (b[1],b[0],1'b0,a[14],a[13],O5[13]);
 carry_1R  carry_inst14 (O5[13],CO[12],PS[13],CO[13]);
 
 LUT_1RN LUT_inst15 (b[1],b[0],1'b0,a[15],a[14],O5[14]);
 carry_1R  carry_inst15 (O5[14],CO[13],PS[14],CO[14]);
 
 // Logic for sign extension of the first row
 LUT_1RS LUT_inst16 (b[1],b[0],1'b0,a[15],a[14],O5[15]);
 carry_1R  carry_inst16 (O5[15],CO[14],PS[15],CO[15]);
 
 assign PS[16]= ~CO[15];
 assign PS[17]= CO[15];
 
endmodule

