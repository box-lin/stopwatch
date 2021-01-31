`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/08 18:34:49
// Design Name: 
// Module Name: DisplayController
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


module DisplayController(
    input clk,rst,en,
    output [6:0] seg,
    output [3:0] seg_an
    );
    wire [1:0] counter;
    wire [3:0] TC;
    wire [3:0] bcd0, bcd1,bcd2,bcd3;
    wire [3:0] mux_connect;
    
    BCD one(.clk(clk),.rst(rst),.bcd_digit(bcd0),.en(en),.tc(TC[0]));
    BCD two(.clk(clk),.rst(rst),.bcd_digit(bcd1),.en(TC[0] & en),.tc(TC[1]));
    BCD three(.clk(clk),.rst(rst),.bcd_digit(bcd2),.en(TC[1]&TC[0]&en),.tc(TC[2]));
    BCD four(.clk(clk),.rst(rst),.bcd_digit(bcd3),.en(TC[2]&TC[1]&TC[0]&en),.tc(TC[3]));
    Counter2bits(.clk(clk),.counterout(counter));
    Mux4_1(.I0(bcd0),.I1(bcd1),.I2(bcd2),.I3(bcd3),.Sel(counter),.Y(mux_connect));
    Seg_decoder(.sw(mux_connect),.rst(rst),.seg(seg));
    Decoder2_4(.rst(rst),.I(counter),.Y(seg_an));

endmodule


module Mux4_1(
    input [3:0] I0,
    input [3:0] I1,
    input [3:0] I2,
    input [3:0] I3,
    input [1:0] Sel,
    output reg [3:0] Y
    );
    always @ (*)begin
        case(Sel)
        2'b00:  Y = I0;
        2'b01:  Y = I1;
        2'b10:  Y = I2;
        2'b11:  Y = I3;
        endcase
    end
endmodule



module Counter2bits(
    input clk,
    output reg [1:0] counterout
    );
    
 always @ (posedge(clk))
 begin
     counterout = counterout + 1;
end
endmodule

module Decoder2_4(
    input rst,
    input [1:0] I,
    output reg [3:0] Y
    );
    always @(*) begin
        case(I)
        2'b00: Y = 4'b1110;
        2'b01: Y = 4'b1101;
        2'b10: Y = 4'b1011;
        2'b11: Y = 4'b0111;
        default: Y = 4'b1111;
        endcase
        if(rst) Y = 4'b0000;
    end
endmodule

module Seg_decoder(
    input rst,
    input [3:0] sw,
    output reg [6:0] seg
    );
    always @(sw,rst)
    begin
        if (rst) seg = 7'b1000000;
        case(sw)
             4'b0000: seg = 7'b1000000; //0
             4'b0001: seg = 7'b1111001; //1
             4'b0010: seg = 7'b0100100; //2
             4'b0011: seg = 7'b0110000; //3
             4'b0100: seg = 7'b0011001; //4
             4'b0101: seg = 7'b0010010; //5
             4'b0110: seg = 7'b0000010; //6
             4'b0111: seg = 7'b1111000; //7
             4'b1000: seg = 7'b0000000; //8
             4'b1001: seg = 7'b0011000; //9
             4'b1010: seg = 7'b0001000; //A
             4'b1011: seg = 7'b0000011; //b
             4'b1100: seg = 7'b1000110; //C
             4'b1101: seg = 7'b0100001; //d
             4'b1110: seg = 7'b0000110; //E
             4'b1111: seg = 7'b0001110; //F
       endcase
       end
endmodule




