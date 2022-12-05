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
input clk,
input rst,
input A_PAD,
input B_PAD,
output reg P0,
output reg P1
);


reg [15:0] a;
reg [15:0] b;
wire [31:0] P;
reg [3:0] count;
reg [4:0] count1;

always@(posedge clk or posedge rst)
begin
if(rst==1)
    begin
      count<=4'b0000;
      count1<=5'b00000;
      end
      else
          begin
           if(count<15)
            begin
              a[count]<=A_PAD;
              b[count]<=B_PAD;
              end
              else
              count<=count+1;

		end
end 
        
always @(posedge clk)
    begin
    	if(count1<=31)
    	begin
    	P0<=P[count1];
    	P1<=P[count1+15];
    	end
    		else 
    			count1=count1+1;
    end




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
