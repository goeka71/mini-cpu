// PC (src/pc.v) : posedge clk에 next_pc를 저장 (reset도 포함)
// Program Counter는 프로그램의 명령에서 현재 실행중인 명령의 주소를 나타냄
// 명령어의 주소는 1씩 늘어남 (물론 분기가 존재하면 jump하는 경우도 있음)
// Positive edge일 때마다 next_pc로 pc값을 바꾸고, next_pc는 1 증가시키는 형식
// 입력 : clk, reset, next_pc[15:0]
// 출력 : pc[15:0]

module pc(clk, reset, next_pc, pc);
    input clk;
    input reset;
    input [15:0] next_pc;
    output reg [15:0] pc;

    always@(posedge clk)
    begin
        if (reset == 1)
            pc <= 0;
        else
            pc <= next_pc;
        $display("time = %t, pc = %d", $time, pc);
    end
endmodule