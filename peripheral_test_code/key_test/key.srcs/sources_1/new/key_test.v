`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/26 15:28:36
// Design Name: 
// Module Name: key_test
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


module key_test(
    input reset,
    input clk,
    input [4:0] key,
    output [4:0] led
    );

reg [4:0] KeyLed;

assign led = KeyLed;

always @(posedge clk or negedge reset)
begin
    if(~reset)
        begin
       KeyLed = 5'b11111;
        end
    else
        begin
        KeyLed <= ~key;
        end
end

endmodule

