`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/26 11:21:33
// Design Name: 
// Module Name: led_test
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


module led_test(
    reset,
    led
    );

input reset;
output reg [15:0] led;
        
always @(*)
begin
if(!reset)
    begin
        led <= 16'b0;
    end
else
    begin
        led <= 16'b1111_0000_1111_0000;
    end
end

endmodule
