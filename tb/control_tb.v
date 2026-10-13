module tb;
    reg  [3:0] opcode;
    wire RegDst, RegWrite, ALUSrc, MemWrite, MemToReg;
    wire [1:0] Branch, ALUOp;

    control u1(
        .opcode(opcode),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp),
        .Branch(Branch),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg)
    );

    integer i;

    initial begin
        $display("opcode | RegDst RegWrite ALUSrc ALUOp Branch MemWrite MemToReg");
        for (i = 0; i < 11; i = i + 1) begin
            opcode = i;
            #10;
            $display("%b   |   %b       %b       %b     %b    %b     %b        %b",
                     opcode, RegDst, RegWrite, ALUSrc, ALUOp, Branch, MemWrite, MemToReg);
        end
        $finish;
    end
endmodule