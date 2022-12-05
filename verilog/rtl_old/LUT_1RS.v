`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 12:05:01 PM
// Design Name: 
// Module Name: LUT_1RS
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


module LUT_1RS(
input I4,I3,I2,I1,I0,
output O5
);

assign O5 = I4|I3&I2&I1&I0;

endmodule
