`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/02 11:22:24
// Design Name: 
// Module Name: led_module
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


module led_module(
    input clk_50MHz,
    input reset,
    input [15:0] result,
    output reg [15:0] led
    );
    
always @(posedge clk_50MHz or negedge reset)
begin
    if(~reset)
    begin
        led <= 16'b0000_0000_0000_0000;
    end
    else
        if(result[0] == 1)
        begin
            led <= 16'b1111_0000_1111_0000;
        end
        else
        begin
            led <= 16'b0000_0000_0000_0000;
        end
    begin
    end
end    
    
endmodule
