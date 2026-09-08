module tb;
  reg  [3:0] a, b;
  wire [4:0] sum;

  adder u1(.a(a), .b(b), .sum(sum));

  initial begin
    a = 3; b = 5;
    #10;
    $display("a=%d, b=%d, sum=%d", a, b, sum);

    a = 7; b = 8;
    #10;
    $display("a=%d, b=%d, sum=%d", a, b, sum);

    $finish;
  end
endmodule