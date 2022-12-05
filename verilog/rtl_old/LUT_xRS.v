`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 10:20:45 PM
// Design Name: 
// Module Name: LUT_xRS
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


module LUT_xRS(i5,i4,i3,i2,i1,i0,o5,o6);
input i5,i4,i3,i2,i1,i0; 
output o5,o6;
wire i0p, i1p, i2p,i3p,i4p; 
wire w1,w2,w3,w4,w5,w6; 
wire temp;
not n1(i0p,i0); 
not n2(i1p,i1); 
not n3(i2p,i2); 
not n4(i3p,i3); 
not n5(i4p,i4); 
and a1(w1,i4p,i2,i1); 
and a2(w2,i4p,i3,i1); 
and a3(w3,i4,i2p,i1p); 
and a4(w4,i4,i2,i0p); 
and a5(w5,i4,i3,i2); 
or(temp,w1,w2,w3,w4,w5);

assign o6= ~i5&temp | i5&(~temp);
assign o5=temp; 
endmodule 