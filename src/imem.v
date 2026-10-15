// Instruction Memory : 명령어 주소(pc)를 넣으면 해당하는 명령어가 출력됨
// 입력 : pc값 (16비트)
// 출력 : 명령어값 (16비트)
// 명령어가 instruction에 배열형식으로 저장되어 있고, pc번째 행의 값을 출력하는 형식임

module imem(pc, imem_o);
    input [15:0] pc;
    output wire [15:0] imem_o;

    reg [15:0] instr [0:63];

    initial begin
        instr[0] = 16'b0100_000_001_000010; // register 1 <- 0+2
        instr[1] = 16'b0100_000_010_000011; // register 2 <- 0+3
        instr[2] = 16'b0000_001_010_011_000; // regiter 3 <- register1 + register2
        instr[3] = 16'b0110_011_010_000100; // mem[9] <- 3
        instr[4] = 16'b0101_011_101_000100; // register 5 <- mem[9]
    end

    assign imem_o = instr[pc[5:0]];
    // pc가 16비트이므로 표현할 수 있는 명령어의 수는 최대 2^{16}개이지만, 여기서는 64개의 명령어만 저장하도록 함(instr 선언부분 참고)
    // 따라서 pc의 하위 6비트(2^6 = 64)만으로도 64개의 명령어를 구분할 수 있음 -> pc[5:0]이라고 한 이유
endmodule