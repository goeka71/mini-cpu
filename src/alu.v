// ADD, SUB, AND, OR
// ALUOp에 따라 각 연산 수행

// 입력 : read1_data | read2_data 혹은 imm 혹은 offset | ALUOp
// 출력 : Zero | 연산 결과값

module alu(r1, r2, ALUOp, res, zero);
    input [15:0] r1, r2;
    input [1:0] ALUOp;
    output reg [15:0] res;
    output reg zero;
    
    always @(*)
    begin
        case (ALUOp)
            2'b00: res = r1 + r2; // 덧셈 = 00
            2'b01: res = r1 - r2; // 뺄셈 = 01
            2'b10: res = r1 & r2; // AND = 10
            2'b11: res = r1 | r2; // OR = 11
        endcase

        if (res == 0) // 이 부분 헷갈림. 0? 1'd0? 15'b000000000000000? 15'b0?
            zero = 1'b1;
        else
            zero = 1'b0;
    end

endmodule