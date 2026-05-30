////simple 4-bit multiplier logic
////edge triggered

module multiplier(
  input [3:0] a,b,
  input clk,
  output reg [7:0] mul
);
  always @(posedge clk) begin
    mul <= a * b;
  end
endmodule
