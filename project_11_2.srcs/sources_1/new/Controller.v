`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/08 18:43:21
// Design Name: 
// Module Name: Controller
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


module Controller(
    input start,stop,incre,clk1,rst,
    output run
    );
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;
    
    reg [2:0] PS,NS;
    
    always@(PS,start,stop,incre)begin
    case(PS)
        S0: if (start) NS = S1;
            else if (incre & ~start) NS = S2;
            else NS = S0;
        S1: if(stop) NS = S0;
            else NS = S1;
        S2: NS = S3;
        S3: if (incre) NS = S3;
            else NS = S0;
        default: NS = S0;    
    endcase
    end
    
    always @ (posedge (clk1), posedge (rst)) begin
    if(rst == 1'b1) PS<=S0;
    else PS<=NS;
    end
    
    assign run = (PS == S1 || PS == S2) ? 1'b1 : 1'b0;
    
endmodule
