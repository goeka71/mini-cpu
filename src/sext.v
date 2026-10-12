// Sign Extend는 6비트짜리 offset / imm을 16비트로 늘리는 역할을 함
    // 즉 양수면 앞을 0으로, 음수면 1로 채우는 작업 진행
// 입력 : imm 혹은 offset [5:0]
// 출력 : 16비트로 늘어난 imm 혹은 offset [15:0]

module sext(in_6bit, out_16bit);
    input [5:0] in_6bit;
    output wire [15:0] out_16bit;

    assign out_16bit = {{10{in_6bit[5]}}, in_6bit}; 
endmodule