`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/02 11:22:49
// Design Name: 
// Module Name: fnd_module
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


module fnd_module(
    input clk_50MHz,
    input reset,
    input [15:0] result,
    output reg [3:0] digit,
    output reg [7:0] fnd
    );

reg [15:0] digit_sel;
    
always @(posedge clk_50MHz or negedge reset)
begin
    if(~reset)
    begin
        digit <= 4'b0000;
        fnd <= 8'b00000011;
        digit_sel <= 0;
    end 
    else
        if(result[1] == 1)
        begin
            digit_sel <= digit_sel + 1'b1;
            case(digit_sel)
            0: begin digit <= 4'b1110; fnd <= 8'b00000011; end
            16384: begin digit <= 4'b1101; fnd <= 8'b10011111; end
            32768: begin digit <= 4'b1011; fnd <= 8'b00100101; end
            49152: begin digit <= 4'b0111; fnd <= 8'b00001101; end 
            endcase
        end
        else
        begin
            digit <= 4'b0000;
            fnd <= 8'b00000011;
            digit_sel <= 0;
        end
    begin
    end
end    
endmodule
