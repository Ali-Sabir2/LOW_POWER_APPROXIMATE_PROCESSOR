`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 10:39:48 AM
// Design Name: 
// Module Name: LUT_1RT
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


module LUT_1RT(i4,i3,i2,i1,i0,o5); // EQ2
input i4,i3,i2,i1,i0; 
output o5; 
wire i0p, i1p, i2p,i3p,i4p; 
wire w1,w2,w3; not n1(i0p,i0);
not n2(i1p,i1); // i1p'
not n3(i2p,i2); //i2p'
not n4(i3p,i2); // i3p'
not n5(i4p,i3);
not n6(i0p,i0);  // i4p'
and a1(w1,i4p,i2,i1); // I3'I2I1
and a2(w2,i3,i3p,i0); // I3I2'I0
and a3(w3,i3,i1p,i0p); //I3I1'I0'
or o1(o5,w1,w2,w3); 
endmodule 
