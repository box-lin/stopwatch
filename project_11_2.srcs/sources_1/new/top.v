`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/09 11:21:49
// Design Name: 
// Module Name: top
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


module top(
    input start,stop,incre,clk,rst,
    output [6:0] seg,
    output [3:0] seg_an
    );
    wire enConnect;
    wire clkPass;
    CLKdiv(.clk(clk),.rst(rst),.terminalcount(49999),.clk_div(clkPass));   
    Controller(.start(start),.stop(stop),.incre(incre),.clk1(clkPass),.rst(rst),.run(enConnect));
    DisplayController(.clk(clkPass),.rst(rst),.seg_an(seg_an),.seg(seg),.en(enConnect));
endmodule
