// READ : 읽을 레지스터의 번호 rn1, rn2을 받고, 해당 레지스터의 값 rd1, rd2를 읽음
// WRITE : 쓸 레지스터 번호 wn와 값 wd를 받고, 레지스터 wn에 값 wd를 씀
// 입력 : rn1 혹은 wn | rn2 혹은 wd | RegWrite | clk
// 출력/행동 : rd1 | rd2 혹은 레지스터 wn에 wd 넣기

module regfile(i_1, i_2, write_data, clk, RegWrite, o_1, o_2);
    input [2:0] i_1;
    input [2:0] i_2;
    input [15:0] write_data;
    input clk;
    input RegWrite;
    output reg [15:0] o_1;
    output reg [15:0] o_2;

    reg [15:0] registers [7:0];

    always@(posedge clk) // Write
    begin
        if (i_1 != 0) begin
            if (RegWrite == 1'b1)
                registers[i_1] <= write_data;
        end
    end

    always@(*) // Read
    begin
        if (i_1 != 0 & i_2 != 0) begin
            o_1 = registers[i_1];
            o_2 = registers[i_2];
        end else if (i_1 == 0) begin
            o_1 = 0;
            o_2 = registers[i_2];
        end else if (i_2 == 0) begin
            o_1 = registers[i_1];
            o_2 = 0;
        end
    end

endmodule