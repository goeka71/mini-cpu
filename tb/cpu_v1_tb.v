module cpu_v1_tb;
    reg clk = 0;
    reg reset;
    wire [15:0] instr;

    integer i;

    cpu v1(.clk(clk), .reset(reset), .instr(instr));

    always #5 clk = ~clk;

    initial begin
        reset = 1;
        #15
        reset = 0;
        
        for (i = 0; i < 11; i = i + 1) begin
            $display("time = %0d, instr = %b", $time, instr);
            #10;
        end
        
        $finish;
    end
endmodule