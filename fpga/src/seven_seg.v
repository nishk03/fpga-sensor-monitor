module seven_seg(
    input clk,              // 100MHz clock
    input [15:0] display_value, // Value to display
    output reg [6:0] seg,   // Segment patterns (a-g)
    output reg [3:0] an     // Anode signals (digit select)
);

// 17-bit counter for 1kHz refresh rate
reg [16:0] refresh_counter = 0;
reg [1:0] digit_sel = 0;      // Current digit (0-3)
reg [3:0] digit_data;         // 4-bit digit value

// Generate 1kHz refresh clock
always @(posedge clk) begin
    refresh_counter <= refresh_counter + 1;
    
    // Create 1kHz enable signal (100MHz/100,000 = 1kHz)
    if (refresh_counter == 100000 - 1) begin
        refresh_counter <= 0;
        digit_sel <= digit_sel + 1;  // Cycle through digits
    end
end

// Digit selection and anode control
always @(*) begin
    case (digit_sel)
        2'b00: begin  // Digit 0 (rightmost)
            an = 4'b1110;          // Enable only rightmost digit
            digit_data = display_value[3:0];  // Least significant 4 bits
        end
        2'b01: begin  // Digit 1
            an = 4'b1101; 
            digit_data = display_value[7:4];
        end
        2'b10: begin  // Digit 2
            an = 4'b1011; 
            digit_data = display_value[11:8];
        end
        2'b11: begin  // Digit 3 (leftmost)
            an = 4'b0111; 
            digit_data = display_value[15:12]; // Most significant 4 bits
        end
    endcase
end

// 7-segment decoder (hex to segment pattern)
always @(*) begin
    case (digit_data)
        4'd0: seg = 7'b0000001;  // Pattern for '0'
        4'd1: seg = 7'b1001111;  // Pattern for '1'
        4'd2: seg = 7'b0010010;  // Pattern for '2'
        4'd3: seg = 7'b0000110;  // Pattern for '3'
        4'd4: seg = 7'b1001100;  // Pattern for '4'
        4'd5: seg = 7'b0100100;  // Pattern for '5'
        4'd6: seg = 7'b0100000;  // Pattern for '6'
        4'd7: seg = 7'b0001111;  // Pattern for '7'
        4'd8: seg = 7'b0000000;  // Pattern for '8'
        4'd9: seg = 7'b0000100;  // Pattern for '9'
        4'd10: seg = 7'b0001000; // 'A'
        4'd11: seg = 7'b1100000; // 'b'
        4'd12: seg = 7'b0110001; // 'C'
        4'd13: seg = 7'b1000010; // 'd'
        4'd14: seg = 7'b0110000; // 'E'
        4'd15: seg = 7'b0111000; // 'F'
        default: seg = 7'b1111111; // All segments off
    endcase
end
endmodule