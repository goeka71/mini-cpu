module tb;
    wire [15:0] pc, next_pc;
    reg clk = 0;
    reg reset;

    pc u1(.clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc));

    always #5 clk = ~clk;

    assign next_pc = pc + 1;

    initial begin
        reset = 1;
        #30
        reset = 0;
        #30
        reset = 1;
        #20
        $finish;
    end
endmodule