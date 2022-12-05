`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 12:18:02 PM
// Design Name: 
// Module Name: PS_Rx
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


module PS_Rx(
input [15:0] a,
input [2:0] b,
input [15:0] x, //partail sum from previous row
output [17:0] PS
    );
    
wire [15:0] O5,O6;
wire [15:0] CO;


 // PS and C0 of LUT type-T   
 LUT_xRT LUT_inst1 (x[0],b[2],b[1],b[0],a[1],a[0],O5[0],O6[0]);
 carry_xR  carry_inst (O5[0],O6[0],b[2],PS[0],CO[0]);
 
 // PS and C0 of LUT type-N
 LUT_xRN LUT_inst2 (x[1],b[2],b[1],b[0],a[2],a[1],O5[1],O6[1]);
 carry_xR  carry_inst2 (O5[1],O6[1],CO[0],PS[1],CO[1]);
 
 LUT_xRN LUT_inst3 (x[2],b[2],b[1],b[0],a[3],a[2],O5[2],O6[2]);
 carry_xR  carry_inst3 (O5[2],O6[2],CO[1],PS[2],CO[2]);
 
 LUT_xRN LUT_inst4 (x[3],b[2],b[1],b[0],a[4],a[3],O5[3],O6[3]);
 carry_xR  carry_inst4 (O5[3],O6[3],CO[2],PS[3],CO[3]);
 
 LUT_xRN LUT_inst5 (x[4],b[2],b[1],b[0],a[5],a[4],O5[4],O6[4]);
 carry_xR  carry_inst5 (O5[4],O6[4],CO[3],PS[4],CO[4]);
 
 LUT_xRN LUT_inst6 (x[5],b[2],b[1],b[0],a[6],a[5],O5[5],O6[5]);
 carry_xR  carry_inst6 (O5[5],O6[5],CO[4],PS[5],CO[5]);
 
 LUT_xRN LUT_inst7 (x[6],b[2],b[1],b[0],a[7],a[6],O5[6],O6[6]);
 carry_xR  carry_inst7 (O5[6],O6[6],CO[5],PS[6],CO[6]);
 
 
 LUT_xRN LUT_inst8 (x[7],b[2],b[1],b[0],a[8],a[7],O5[7],O6[7]);
 carry_xR  carry_inst8 (O5[7],O6[7],CO[6],PS[7],CO[7]);
 
 LUT_xRN LUT_inst9 (x[8],b[2],b[1],b[0],a[9],a[8],O5[8],O6[8]);
 carry_xR  carry_inst9 (O5[8],O6[8],CO[7],PS[8],CO[8]);
 
 LUT_xRN LUT_inst10 (x[9],b[2],b[1],b[0],a[10],a[9],O5[9],O6[9]);
 carry_xR  carry_inst10 (O5[9],O6[9],CO[8],PS[9],CO[9]);
  
 LUT_xRN LUT_inst11 (x[10],b[2],b[1],b[0],a[11],a[10],O5[10],O6[10]);
 carry_xR  carry_inst11 (O5[10],O6[10],CO[9],PS[10],CO[10]);
  
 LUT_xRN LUT_inst12 (x[11],b[2],b[1],b[0],a[12],a[11],O5[11],O6[11]);
 carry_xR  carry_inst12 (O5[11],O6[11],CO[10],PS[11],CO[11]);
  
 LUT_xRN LUT_inst13 (x[12],b[2],b[1],b[0],a[13],a[12],O5[12],O6[12]);
 carry_xR  carry_inst13 (O5[12],O6[12],CO[11],PS[12],CO[12]);
 
 LUT_xRN LUT_inst14 (x[13],b[2],b[1],b[0],a[14],a[13],O5[13],O6[13]);
 carry_xR  carry_inst14 (O5[13],O6[13],CO[12],PS[13],CO[13]);
 
 LUT_xRN LUT_inst15 (x[14],b[2],b[1],b[0],a[15],a[14],O5[14],O6[14]);
 carry_xR  carry_inst15 (O5[14],O6[14],CO[13],PS[14],CO[14]);
 
 // Logic for sign extension of the first row
 LUT_xRS LUT_inst16 (x[15],b[2],b[1],b[0],a[15],a[14],O5[15],O6[15]);
 carry_xR  carry_inst16 (O5[15],O6[15],CO[14],PS[15],CO[15]);
 
 assign PS[16]= ~CO[15];
 assign PS[17]= CO[15];
endmodule
