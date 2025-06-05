module counter(
    input clk,
    output reg [15:0] count = 0 // 0000-9999
  );

  reg [26:0] timer = 0;

  always @(posedge clk )
  begin
    timer <= timer + 1; // Increment timer at every clock cycle

    if (timer == 100000000 - 1) 
    begin

      timer <= 0;
      count <= count + 1;

    end

  end

endmodule
