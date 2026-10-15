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

/* 3차 : Load & Store
    - LOAD : imm + rs1라는 주소의 값을 레지스터 rd에 저장 MemtoReg = 1
    - STORE : rs2의 값을 imm+rs1라는 주소에 저장 MemWrite = 1

    (1~4는 2차와 동일)
    5-1. (Store) dmem.v : MemWrite = 1 -> read2 data의 값을 메모리의 ALU결과값 주소에 WRITE
    5-2. (Load) dmem.v : read_data에 ALU결과값 주소의 값이 READ
        - MemToReg = 1 -> 레지스터 rd(_8_6)에 READ한 값을 WRITE (regfile.v)
*/

/* 4차 : BEQ & BNE
    - BEQ (0111) : rs1=rs2이면 offset+pc+1로 분기
    - BNE (1000) : rs1≠rs2이면 offset+pc+1로 분기

    (1~3은 2차와 동일)
    4. ALUSrc = 0에 따라 read2 data가 ALU에 들어감 & ALUOp = sub
    5. alu.v의 zero -> Branch의 하위비트와 XOR(다르면 1) + 상위비트와 AND
        5-1. (BEQ : Branch = 10) zero = 1일때 1
        5-2. (BNE : Branch = 11) zero = 0일 때 1
    6. 위 결과가 1인 경우, pc + offset + 1을 next pc로 

*/

module cpu(
    input clk,
    input reset,
    output [15:0] instr,
    output RegWrite,
    output [15:0] load_data,
    output [15:0] ALU_res
);
    wire [15:0] next_pc;
    wire [15:0] pc; // 현재 실행 중인 명령어의 주소
    //wire [15:0] instr; // 현재 실행 중인 명령어
    // 명령어 구성
    wire [3:0] opcode;
    wire [2:0] _11_9, _8_6, _5_3; // 참고 : rd는 destination register
    wire [5:0] _5_0;

    //제어신호 
    wire RegDst, ALUSrc, MemWrite, MemToReg;//, RegWrite;
    wire [1:0] ALUOp, Branch;

    // 16비트 : 레지스터값 & sign extend된 값
    wire [15:0] rd1, rd2; // 참고 : 여기서 rd는 register data
    wire [15:0] extend;

    wire [2:0] write_addr;
    //wire [15:0] ALU_res;
    wire zero;

    //wire [15:0] load_data;

    wire branch0, branch1;
    wire PCSrc;

//-----------------------------
    assign next_pc = PCSrc ? (extend + pc + 1) : (pc + 1);

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
    
    // RegDst MUX
    assign write_addr = RegDst ? _8_6 : _5_3; // RegDst가 1이면 [8:6]레지스터에 쓰고, 0이면 [5:3]레지스터에 씀

    // Branch 상, 하위 비트 정의
    assign branch0 = Branch[0]; // 하위비트 
    assign branch1 = Branch[1]; // 상위비트

    // 레지스터 파일 + MemToReg MUX
    // MemToReg MUX : 1이면 load_data WRITE, 0이면 ALU_res WRITE
    regfile u_regfile(.r1_addr(_11_9), .r2_addr(_8_6), .rd_addr(write_addr), .write_data(MemToReg ? load_data : ALU_res), .clk(clk), .RegWrite(RegWrite), .o_1(rd1), .o_2(rd2));
    // r1_addr의 내용이 rd1, r2_addr의 내용이 rd2에 들어감.

    // ALU + ALUSrc MUX
    alu u_alu(.r1(rd1), .r2(ALUSrc ? extend : rd2), .ALUOp(ALUOp), .res(ALU_res), .zero(zero));
    // ALUSrc가 1이면 extend과 rd1, 0이면 rd1과 rd2를 연산
    // ALU의 결과값이 write_data 저장
    assign PCSrc = (branch0 ^ zero) && branch1; // zero의 결과에 따라 PCSrc 저장


    // WRITE : write data = rd2, addr = ALU_res
    // READ : addr = ALU_res
    dmem u_dmem(.MemWrite(MemWrite), .addr(ALU_res), .write_data(rd2), .clk(clk), .read_data(load_data));

endmodule