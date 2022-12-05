`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 10:18:23 PM
// Design Name: 
// Module Name: LUT_xRN
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


module LUT_xRN(i5,i4,i3,i2,i1,i0,o5,o6);
input i5,i4,i3,i2,i1,i0; 
output o5,o6;
wire i0p, i1p, i2p,i3p,i4p;
wire w1,w2,w3,w4,w5,w6,w7;
wire temp;
not n1(i0p,i0); 
not n2(i1p,i1); 
not n3(i2p,i2); 
not n4(i3p,i3); 
not n5(i4p,i4); 
and a1(w1,i4p,i3p,i2,i1); // I4'I3'I2I1
and a2(w2,i4p,i3,i2p,i1); // I4'I3I2'I1
and a3(w3,i3,i2,i0);      // I3I2I0
and a4(w4,i4,i3p,i2p,i0); // I4I3'I2'I0
and a5(w5,i4,i2,i1p);     // I4I2I1'
and a6(w6,i4,i3,i1p);     // I4I3I1'
and a7(w7,i4,i3,i2);      // I4I3I2
or o1(temp,w1,w2,w3,w4,w5,w6,w7); 

assign o6= ~i5&temp | i5&(~temp);
assign o5=temp; 
endmodule 

