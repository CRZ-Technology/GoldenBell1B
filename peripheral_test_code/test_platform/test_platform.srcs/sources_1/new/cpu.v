`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/02 11:21:49
// Design Name: 
// Module Name: cpu
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


module cpu(
    input clk_50MHz,
    input reset,
    input [5:0] key,
    output [15:0] led,
    output [3:0] digit,
    output [7:0] fnd
    );

reg [15:0] result;

always @(posedge clk_50MHz or negedge reset)
begin
    if(~reset)    
    begin
        result <= 16'b0000_0000_0000_0000;
    end 
    else
    begin
        result <= key;
    end
end    

led_module LED(
    .clk_50MHz(clk_50MHz),
    .reset(reset),
    .result(result),
    .led(led)
);

fnd_module FND(
    .clk_50MHz(clk_50MHz),
    .reset(reset),
    .result(result),
    .digit(digit),
    .fnd(fnd)
);
endmodule
