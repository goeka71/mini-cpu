module tb;
    reg [5:0] in_6bit;
    wire [15:0] out_16bit;

    sext u1(.in_6bit(in_6bit), .out_16bit(out_16bit));

    initial begin
        in_6bit = 6'b111000;
        #5
        $display("out_16bit = %b", out_16bit);
        $finish;
    end
endmodule