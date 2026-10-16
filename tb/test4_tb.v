module test1_tb;
    reg clk = 0;
    reg reset;
    wire [15:0] pc, instr, load_data, ALU_res;
    wire RegWrite;

    integer i;

    wire signed [15:0] alu_s = ALU_res;

    cpu v1(.clk(clk), .pc(pc), .reset(reset), .instr(instr), .RegWrite(RegWrite), .load_data(load_data), .ALU_res(ALU_res));

    always #5 clk = ~clk;

    initial begin
        reset = 1;
        #15
        reset = 0;
        
        for (i = 0; i < 85; i = i + 1) begin
            $display("time = %0d, pc = %0d, instr = %b, RegWrite = %b, Memory Load Data = %0d, ALU Result = %0d\n", $time, pc, instr, RegWrite, load_data, alu_s);
            #10;
        end
        
        $display("MAX Number = %0d", v1.u_regfile.registers[3]);
        $finish;
    end
endmodule