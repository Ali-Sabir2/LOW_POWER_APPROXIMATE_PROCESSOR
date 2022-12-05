`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 10:48:14 AM
// Design Name: 
// Module Name: carry_1R
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


module carry_1R(
input O5,CI,
output O,CO
    );
    
    assign CO = O5 & CI;
    assign O = O5^CI;
endmodule
