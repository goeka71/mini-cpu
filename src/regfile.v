// READ : 읽을 레지스터의 번호 rn1, rn2을 받고, 해당 레지스터의 값 rd1, rd2를 읽음
// WRITE : 쓸 레지스터 번호 wn와 값 wd를 받고, 레지스터 wn에 값 wd를 씀
// 입력 : rn1 | rn2 | rd | write_data | RegWrite | clk
// 출력/행동 : rd1 | rd2 혹은 레지스터 wn에 wd 넣기

module regfile(r1_addr, r2_addr, rd_addr, write_data, clk, RegWrite, o_1, o_2);
    input [2:0] r1_addr, r2_addr, rd_addr;
    input [15:0] write_data;
    input clk;
    input RegWrite;
    output reg [15:0] o_1;
    output reg [15:0] o_2;

    reg [15:0] registers [0:7];

    always@(posedge clk) // Write
    begin
        if (rd_addr != 0) begin
            if (RegWrite == 1'b1)
                registers[rd_addr] <= write_data;
        end
        //$display("Write %d", write_data);
    end

    always@(*) // Read
    begin
        if (r1_addr != 0 & r2_addr != 0) begin
            o_1 = registers[r1_addr];
            o_2 = registers[r2_addr];
        end else if (r1_addr == 0) begin
            o_1 = 0;
            o_2 = registers[r2_addr];
        end else if (r2_addr == 0) begin
            o_1 = registers[r1_addr];
            o_2 = 0;
        end
    end

endmodule