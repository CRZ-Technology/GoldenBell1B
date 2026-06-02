`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/01 16:38:53
// Design Name: 
// Module Name: buzzer_ad_test
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


module buzzer_ad_test(
    input clk,
    input reset,
    output buzzer
    );

localparam BUZZER_INIT = 0;
localparam BUZZER_ON   = 1;
localparam BUZZER_OFF  = 2;

localparam ONE_SECOND = 50_000_000;

reg rBuzzer;
reg [2:0] alert_num;
reg [31:0] counter;
reg [2:0] state;
reg one_second;

assign buzzer = rBuzzer;

always @(posedge clk or negedge reset)
begin
    if(~reset)
    begin
        counter <= 0;
        one_second <= 0;
    end
    else
    begin
        counter <= counter + 1;
        one_second <= 0;
        
        if(counter == ONE_SECOND)
        begin
            counter <= 0;
            one_second <= 1;
        end
    end      
end

always @(posedge clk or negedge reset)
begin
    if(~reset)
    begin
        rBuzzer <= 0;
        alert_num <= 0;
        state <= BUZZER_INIT;
    end
    else
    begin
    case (state)
        BUZZER_INIT:
        begin
            rBuzzer <= 0;

            if(one_second == 1)
            begin
                alert_num <= alert_num + 1;
                rBuzzer <= 1;
                state <= BUZZER_ON;
            end
        end
        
        BUZZER_ON:
        begin
            if(one_second == 1)
            begin
                rBuzzer <= 0;
                state <= BUZZER_OFF;
            end        
        end
        
        BUZZER_OFF:
        begin
            if(alert_num < 4 && one_second == 1)
            begin
                alert_num <= alert_num + 1;
                rBuzzer <= 1;
                state <= BUZZER_ON;
            end        
        end
        
        default:
        begin
            rBuzzer <= 0;    
            state <= BUZZER_INIT;    
        end
    endcase        
    end
end    
    
endmodule
