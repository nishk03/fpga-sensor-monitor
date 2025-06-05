module blink_led(
    input clk,          // 100MHz clock
    output reg led = 0  // LED output
);

// 27-bit counter (134 million max value for 1-second count
reg [26:0] count = 0;

always @(posedge clk) begin
    count <= count + 1;
    if (count == 100_000_000) begin  // 1 second delay
        led <= ~led;      // Toggle LED
        count <= 0;       // Reset counter
    end
end
endmodule