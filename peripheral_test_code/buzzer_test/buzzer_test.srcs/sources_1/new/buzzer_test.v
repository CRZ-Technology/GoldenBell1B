`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/26 16:38:36
// Design Name: 
// Module Name: buzzer_test
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


module buzzer_test(
    input clk,
    input reset,
    output buzzer
    );

reg rBuzzer;

assign buzzer = rBuzzer;
    
always @(posedge clk or negedge reset)
begin
    if(~reset)
        rBuzzer <= 0;
    else
        rBuzzer <= 1;
end
endmodule
