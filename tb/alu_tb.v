module tb;
    reg [15:0] r1, r2;
    reg [1:0] ALUOp;
    wire [15:0] res;
    wire zero;

    alu u1(.r1(r1), .r2(r2), .ALUOp(ALUOp), .res(res), .zero(zero));

    initial begin
        r1 = 16'b0000000000000011;
        r2 = 16'b0000000000000001;
        ALUOp = 2'b01;
        #10

        $display("r1 = %d, r2 = %d, ALUOp = %d", r1, r2, ALUOp);
        $display("res = %d, zero = %d", res, zero);
        $finish;
    end
endmodule