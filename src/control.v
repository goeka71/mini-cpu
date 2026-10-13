// Control Unit은 imem으로부터 받은 opcode에 따라 제어신호를 컨트롤하는 부분
// 제어신호표 참고해서 case문으로 작성

module control(opcode, RegDst, RegWrite, ALUSrc, ALUOp, Branch, MemWrite, MemToReg);
    input [3:0] opcode;
    output reg RegDst, RegWrite, ALUSrc, MemWrite, MemToReg;
    output reg [1:0] ALUOp, Branch;

    always@(*)
    begin
        RegDst = 1;
        RegWrite = 1;
        ALUSrc = 0;
        ALUOp = 2'b00;
        Branch = 2'b00;
        MemWrite = 0;
        MemToReg = 0;

        case (opcode)
            4'b0000:
                RegDst = 0;

            4'b0001: begin
                RegDst = 0;
                ALUOp = 2'b01;
            end

            4'b0010: begin
                RegDst = 0;
                ALUOp = 2'b10;
            end

            4'b0011: begin
                RegDst = 0;
                ALUOp = 2'b11;
            end

            4'b0100:
                ALUSrc = 1;

            4'b0101: begin
                ALUSrc = 1;
                MemToReg = 1;
            end

            4'b0110: begin
                RegWrite = 0;
                ALUSrc = 1;
                MemWrite = 1;
            end

            4'b0111: begin
                RegWrite = 0;
                ALUOp = 2'b01;
                Branch = 2'b10;
            end

            4'b1000: begin
                RegWrite = 0;
                ALUOp = 2'b01;
                Branch = 2'b11;
            end
            
            default: RegWrite = 0;
        endcase
    end
endmodule