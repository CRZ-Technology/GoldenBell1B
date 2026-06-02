`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/26 16:14:49
// Design Name: 
// Module Name: dip_switch
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


module dip_switch(
    input clk,
    input reset,
    input [5:0] dipsw,
    output [5:0] led
    );

reg [5:0] rLed;

assign led = rLed;

always @(posedge clk or negedge reset)
begin
    if(~reset)
        begin
        rLed <= 6'b000000;
        end
    else
        begin
        rLed <= ~dipsw;
        end
end

endmodule
