module cpu_v1_tb;
    reg clk = 0;
    reg reset;
    wire [15:0] instr, load_data, ALU_res;
    wire RegWrite;

    integer i;

    cpu v1(.clk(clk), .reset(reset), .instr(instr), .RegWrite(RegWrite), .load_data(load_data), .ALU_res(ALU_res));

    always #5 clk = ~clk;

    initial begin
        reset = 1;
        #15
        reset = 0;
        
        for (i = 0; i < 15; i = i + 1) begin
            $display("time = %0d, instr = %b, RegWrite = %b, Memory Load Data = %0d, ALU Result = %0d", $time, instr, RegWrite, load_data, ALU_res);
            #10;
        end
        
        for (i = 0; i < 6; i = i + 1) begin
            $display(v1.u_regfile.registers[i]);
        end
        $finish;
    end
endmodule