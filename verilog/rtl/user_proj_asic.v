
reg [15:0] A;
reg [15:0] B;
reg [5:0] count;
reg [5:0] count2;
// Result  //
reg [31:0] P;
wire clk;
wire rst;
wire sel;
assign clk=(sel)?wb_clk_i:user_clock2;
assign rst=wb_rst_i;
assign clk=wb_clk_i;


    always @(posedge clk or posedge rst) 
    begin 
    // Always block to assign A
        if(rst) 
        begin
       	 A<=0;
       	 B<=0;
       	 count<=5'b0000;
                count2<=5'b0000;
       	 
       end
       else 
       begin
 
       		if(count<15)
       		begin
       			 A[count]<=A_PAD;
      				 B[count]<=B_PAD;
       			 count<=count+1;
       		end

       
	               else if(count2<15)
	               begin
       			 	OUT_1<=P[count2];
        				OUT_2<=P[15+count2];
        				count2<=count2+1;
                      end
    end
    end
  
    
    
    
  
   // Inverter// 
    assign io_out[2] =~io_in[2];
    
   
  	
    mult_asic_16x16 MUL(
        .a(A),
        .b(B),
        .P(P),
    );


endmodule	// user_project_wrapper



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






module LUT_xRT(i5,i4,i3,i2,i1,i0,o5,o6);
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
and a1(w1,i4p,i3p,i2,i1); 
and a2(w2,i4p,i3,i2p,i1); 
and a3(w3,i3,i2,i0); 
and a4(w4,i4,i3p,i2p,i0p); 
and a5(w5,i4p,i2p,i0p); 
and a6(w6,i4,i3,i2);
 or o1(temp,w1,w2,w3,w4,w5,w6);
 
assign o6 = ~i5&temp | i5&(~temp);
assign o5 = temp; 
endmodule 



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


module LUT_1RS(
input I4,I3,I2,I1,I0,
output O5
);

assign O5 = I4|I3&I2&I1&I0;

endmodule



module LUT_1RN(
input I4,I3,I2,I1,I0,
output O5
);

assign O5 = I4|I3&I2&I1&I0;

endmodule




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




module carry_1R(
input O5,CI,
output O,CO
    );
    
    assign CO = O5 & CI;
    assign O = O5^CI;
endmodule

















`default_nettype wire
