/* 1&2차 : R타입 + addi
    1. pc.v 결과값 → imem.v
    2. imem.v 결과값 분할
        - [15:12] → control.v : 제어신호들 출력
            - RegDst = 1 : write addr = [8:6]
            - ALUSrc = 1 : EXTND를 거친 offset이 ALU에
            - RegDst = 0 : write addr = [5:3]
            - ALUSrc = 0 : [8:6]레지스터의 값이 ALU에
            - 참고) R타입은 RegDst, ALUSrc = 0, addi는 모두 1
        - [5:0] -> sext.v : sign extension 진행
    3. regfile.v에서 read1 addr, read2 addr의 값 READ
        - 결과적으로 16비트짜리 read1 data, read2 data, extended offset이 생김
    4. ALUSrc에 따라 ALU에 들어가는 값 결정
    5. alu.v 결과값 -> regfile.v에서 WRITE
        - RegDst에 따라 write addr 결정
*/

module cpu(
    input clk,
    input reset,
    output [15:0] instr
);
    wire [15:0] next_pc;
    wire [15:0] pc; // 현재 실행 중인 명령어의 주소
    //wire [15:0] instr; // 현재 실행 중인 명령어
    // 명령어 구성
    wire [3:0] opcode;
    wire [2:0] _11_9, _8_6, _5_3; // 참고 : rd는 destination register
    wire [5:0] _5_0;

    //제어신호 
    wire RegDst, RegWrite, ALUSrc, MemWrite, MemToReg;
    wire [1:0] ALUOp, Branch;

    // 16비트 : 레지스터값 & sign extend된 값
    wire [15:0] rd1, rd2; // 참고 : 여기서 rd는 register data
    wire [15:0] extend;

    wire [2:0] write_addr;
    wire [15:0] write_data;
    wire zero;

//-----------------------------
    assign next_pc = pc + 1;

    pc u_pc(.clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc)); // 결과값 = pc
    imem u_imem(.pc(pc), .imem_o(instr)); // 결과값 = pc가 가리키는 명령어 = instr

    // 명령어 분할
    assign opcode = instr[15:12];
    assign _11_9 = instr[11:9];
    assign _8_6 = instr[8:6];
    assign _5_3 = instr[5:3];

    assign _5_0 = instr[5:0]; // addi의 imm
    sext u_sext(.in_6bit(_5_0), .out_16bit(extend)); // 16비트로 늘어난 imm = extend

    // 제어신호 도출
    control u_control(.opcode(opcode), .RegDst(RegDst), .RegWrite(RegWrite), .ALUSrc(ALUSrc), .ALUOp(ALUOp), .Branch(Branch), .MemWrite(MemWrite), .MemToReg(MemToReg));
    
    assign write_addr = RegDst ? _8_6 : _5_3; // RegDst가 1이면 [8:6]레지스터에 쓰고, 0이면 [5:3]레지스터에 씀

    // 레지스터 파일
    regfile u_regfile(.r1_addr(_11_9), .r2_addr(_8_6), .rd_addr(write_addr), .write_data(write_data), .clk(clk), .RegWrite(RegWrite), .o_1(rd1), .o_2(rd2));
    // r1_addr의 내용이 rd1, r2_addr의 내용이 rd2에 들어감.

    alu u_alu(.r1(rd1), .r2(ALUSrc ? extend : rd2), .ALUOp(ALUOp), .res(write_data), .zero(zero));
    // ALUSrc가 1이면 extend과 rd1, 0이면 rd1과 rd2를 연산

endmodule