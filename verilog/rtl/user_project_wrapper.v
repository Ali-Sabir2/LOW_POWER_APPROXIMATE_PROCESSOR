// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vdd,		// User area 5.0V supply
    inout vss,		// User area ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [63:0] la_data_in,
    output [63:0] la_data_out,
    input  [63:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);
reg [15:0] A;
reg [15:0] B;
wire [31:0] P;


reg [3:0] count;
reg [4:0] count2;


// Result  //
reg [31:0] P;



parameter A_OFF = 8'h00, B_OFF = 8'h04, P1_OFF=8'h08;
    //  WB Interface
    //  3 32 regsisters:
    //  A  (RW)    0x00 
    //  A  (RW)    0x04
    //  P   (RO)    0x08
   
    wire                valid           = wbs_stb_i & wbs_cyc_i ;
    wire                we              = wbs_we_i && valid;
    wire                re              = ~wbs_we_i && valid;
    wire [3:0]          byte_wr_en      = wbs_sel_i & {4{we}}; 
    wire                we_A_reg       = we & (wbs_adr_i[7:0] == A_OFF);
    wire                we_B_reg       = we & (wbs_adr_i[7:0] == B_OFF);
    wire                re_A_reg       = re & (wbs_adr_i[7:0] == A_OFF);
    wire                re_B_reg       = re & (wbs_adr_i[7:0] == B_OFF);
    wire                re_P1_reg      = re & (wbs_adr_i[7:0] == P1_OFF);

    //assign wb_clk_i = wb_wb_clk_i_i;
    //assign A = {A11,A12,A21,A22};
    //assign B = {B11,B12,B21,B22};
    
    
    //io_in[3]ect wb_rst_i (wb or pad)
    
    
   

//io_in[3]ect inp (wb or pad), accumulate in case of pad, take whole 32 bits in case of wishbone
    always @(posedge wb_clk_i or posedge wb_rst_i) 
    begin // Always block to assign A
    if(wb_rst_i==1)
    begin
      count<=4'b0000;
      count2<=5'b00000;
      end
      else
      begin
    if(io_in[3]==0)
    begin
    
        if(wb_rst_i) begin
        
        A<=0;
        B<=0;

            /*A11 <= 8'h0;
            A12 <= 8'h0;
            A21 <= 8'h0;
            A22 <= 8'h0;
            B11 <= 8'h0;
            B12 <= 8'h0;
            B21 <= 8'h0;
            B22 <= 8'h0;*/
            end
        else if(we_A_reg)  
        begin
        A<=wbs_dat_i[15:0];
        /*
            A11 <= wbs_dat_i[7:0];
            A12 <= wbs_dat_i[15:8];
            A21 <= wbs_dat_i[23:16];
            A22 <= wbs_dat_i[31:24];*/
            end
         else if(we_B_reg)
         begin
         B<=wbs_dat_i[15:0];
         /*
            B11 <= wbs_dat_i[7:0];
            B12 <= wbs_dat_i[15:8];
            B21 <= wbs_dat_i[23:16];
            B22 <= wbs_dat_i[31:24];
            end*/
           end
       else if (io_in[3]==1)
       begin
       
       if(count<15)
       begin
       A[count]<=io_in[0];
       B[count]<=io_in[1];
       count<=count+1;
       end
       end
           
    end
	end
	    end
    
    
    //reset the counters
    //Give output through pads
    always @(posedge wb_clk_i)
    begin
    io_out[0]<=P[count2];
    io_out[1]<=P[15+count2];
    count2<=count2+1;
    end
    
    
    //map output to memory through wishbone
    assign      wbs_dat_o   =   (re_P1_reg) ?    P  :
                                (re_A_reg)  ?    A  :
                                (re_B_reg)  ?    B  :
                                32'hDEADBEEF; 

    assign      wbs_ack_o   =   (we_A_reg || we_B_reg || (re_P1_reg && done))?   1'b1    :   1'b0;
   
   // CHecking chip is properly working//
   // Inverter// 
    assign io_out[2] =~io_in[2];
    
   
  	
    mult_asic_16x16 mprj(
        .a(A),
        .b(B),
        .P(P),
    );


endmodule	// user_project_wrapper

`default_nettype wire
