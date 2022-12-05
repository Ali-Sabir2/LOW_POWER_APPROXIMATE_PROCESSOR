`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 03:31:43 PM
// Design Name: 
// Module Name: carry_xR
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


module carry_xR(
    input O5,
    input O6,
    input CI,
    output O,
    output CO
    );
    
    
    assign CO= ~O6&O5 | O6&(~O5);
    assign O= ~O6&CI | O6&(~CI);
    
endmodule
