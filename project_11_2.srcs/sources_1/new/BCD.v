`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/09 13:05:44
// Design Name: 
// Module Name: BCD
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

module BCD(
    input clk,rst,en,
    output tc,
    output reg [3:0] bcd_digit
    );

always @ (posedge(clk), posedge(rst))
begin
    if (rst) bcd_digit <= 0;
    else if (en) begin
            if(bcd_digit == 4'b1001)
            begin
                bcd_digit = 4'b0000;
                end
                else   
                begin bcd_digit = bcd_digit + 1;
                end 
     end 
  end 
    assign tc = (bcd_digit == 4'b1001)? 1:0;
endmodule

