module top(
    input clk,        // 100MHz clock
    output [6:0] seg, // 7-segment segments
    output [3:0] an   // Digit anodes
);

// Internal wire for counter value
wire [15:0] counter_val;

// Instantiate counter module
counter my_counter(
    .clk(clk),
    .count(counter_val)
);

// Instantiate 7-segment display
seven_seg display(
    .clk(clk),
    .display_value(counter_val),
    .seg(seg),
    .an(an)
);

endmodule