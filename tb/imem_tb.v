module tb;
    reg [15:0] pc;
    wire [15:0] imem_o;

    imem u1(.pc(pc), .imem_o(imem_o));

    initial begin
        pc = 0;
        #5
        $display("pc = %d, instruction = %d", pc, imem_o);

        pc = 1;
        #5
        $display("pc = %d, instruction = %d", pc, imem_o);

        pc = 2;
        #5
        $display("pc = %d, instruction = %d", pc, imem_o);
        $finish;
    end
endmodule