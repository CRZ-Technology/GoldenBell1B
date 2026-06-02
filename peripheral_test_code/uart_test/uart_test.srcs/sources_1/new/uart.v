`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/26 15:04:08
// Design Name: 
// Module Name: uart
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


module uart(
   input clk_50MHz,
	 output TXD,
	 input RXD,
	 output reg [15:0] led
    );
   // OUT

parameter CLOCKS_PER_BIT = 1302; // baud rate : 38400, Clock : 50MHz
parameter CLOCKS_WAIT_FOR_RECEIVE = 651;
parameter MAX_TX_BIT_COUNT = 9;
parameter MAX_DATA_BUFFER_INDEX = 10;

reg [10:0] tx_clk_count=0; // clock count
reg [3:0] tx_bit_count=0; // bit count [start bit | d0 | d1 | d2 | d3 | d4 | d5 | d6 | d7 | stop bit]
reg [3:0] data_buffer_index=0;
reg [3:0] data_buffer_base=0;
reg [7:0] data_buffer[0:9]; // data buffer
reg [7:0] data_tx=0; // data to transmit
reg [7:0] rx_data=0;
reg [3:0] rx_bit_count=0;
reg [11:0] rx_clk_count=0;
reg state_rx=0;
reg tx_bit=0;

//
reg [24:0]cnt =0;
reg reset = 1'b1;
reg [2:0]reset_cnt = 0;
	
	// INST_TAG_END ------ End INSTANTIATION Template ---------

always@(posedge clk_50MHz)
begin
	if(reset == 1'b1)
	reset_cnt <= reset_cnt + 1'b1;
	if(reset_cnt == 4'd7)
	reset <= 1'b0;
end 

always@(posedge clk_50MHz)
begin
	if(reset == 1'b1)
	begin
	cnt <= 32'd0;
	led <= 16'b0;

	end 
	else 
		begin
			if(cnt == 32'd25000000)
			begin
			cnt <= 32'd0;
			led <= ~led;
			end 
			else cnt <= cnt + 1'b1;
		end 
end 
   // Transmitter Process
    // at every rising edge of the clock
    always @ (posedge clk_50MHz)
    begin
        if(reset == 1)begin
            tx_clk_count = 0;
            tx_bit_count = 0;
            tx_bit = 1;                     // set idle
            data_buffer_index = 0;          // data index
        end
        else begin
            // transmit data until the index became the same with the base index
            if ( data_buffer_index != data_buffer_base ) begin
                if (tx_clk_count == CLOCKS_PER_BIT) begin
                    if (tx_bit_count == 0) begin
                        tx_bit = 1'b1;     // idle bit
                        tx_bit_count = 1'b1;
                        data_tx = data_buffer[data_buffer_index];
                    end
                    else if (tx_bit_count == 1) begin
                        tx_bit = 0;     // start bit
                        tx_bit_count = 2;
                    end
                    else if (tx_bit_count <= MAX_TX_BIT_COUNT) begin
                        tx_bit = data_tx[tx_bit_count-2];   // data bits
                        tx_bit_count = tx_bit_count + 1'b1;
                    end
                    else begin
                        tx_bit = 1;     // stop bit
								
                        data_buffer_index = data_buffer_index + 1'b1;  // if the index exceeds its maximum, it becomes 0.
                        if(data_buffer_index==4'd10)  ///reset!
								begin
									data_buffer_index=4'd0;
								end 
								tx_bit_count = 0;
                    end
                    tx_clk_count = 0;   // reset clock count
                end
                 
                tx_clk_count = tx_clk_count + 1'b1;        // increase clock count
            end
        end
    end
     
    // Receiver Processs
    // at every rising edge of the clock
    always @ (posedge clk_50MHz)
    begin
        if (reset == 1) begin
            rx_clk_count = 0;
            rx_bit_count = 0;
            data_buffer_base = 0;               // base index
            state_rx = 0;
        end
        else begin
            // if not receive mode and start bit is detected
            if (state_rx == 0 && RXD == 0) begin
                state_rx = 1;       // enter receive mode
                rx_bit_count = 0;
                rx_clk_count = 0;
            end
            // if receive mode
            else if (state_rx == 1) begin
                 
                if(rx_bit_count == 0 && rx_clk_count == CLOCKS_WAIT_FOR_RECEIVE) begin
                    rx_bit_count = 1;
                    rx_clk_count = 0;
                end
                else if(rx_bit_count < 9 && rx_clk_count == CLOCKS_PER_BIT) begin
                    rx_data[rx_bit_count-1] = RXD;
                    rx_bit_count = rx_bit_count + 1'b1;
                    rx_clk_count = 0;
                end
                // stop receiving
                else if(rx_bit_count == 9 && rx_clk_count == CLOCKS_PER_BIT && RXD == 1) begin
                    state_rx = 0;
                    rx_clk_count = 0;
                    rx_bit_count = 0;
                     
                    // transmit the received data back to the host PC.
                    data_buffer[data_buffer_base] = rx_data;
                    data_buffer_base = data_buffer_base + 1'b1;        // if the index exceeds its maximum, it becomes 0.
						  if(data_buffer_base == 4'd10)
						  begin
						  data_buffer_base = 4'd0;
						  end 
					 end
                // if stop bit is not received, clear the received data
                else if(rx_bit_count == 9 && rx_clk_count == CLOCKS_PER_BIT && RXD != 1) begin
                    state_rx = 0;
                    rx_clk_count = 0;
                    rx_bit_count = 0;
                    rx_data = 8'b00000000;      // invalidate
                end
                rx_clk_count = rx_clk_count + 1'b1;
            end
        end
         
    end
     
    assign TXD = tx_bit;
endmodule
