// Data Memory는 프로그램이 다루는 데이터를 담아두는 메모리!
// load : 주소 입력 -> 내용물 출력 (clk와 무관)
// store : 주소 & 저장할 값 입력 -> posedge에 저장
// 입력 : MemWrite | addr | Write data | clk
// 출력/행동 : rd 혹은 주소 addr에 Write data 넣기

module dmem(MemWrite, addr, write_data, clk, read_data);
    input MemWrite;
    input [15:0] addr;
    input [15:0] write_data;
    input clk;
    output reg [15:0] read_data;

    reg [15:0] data [0:7];

    always@(posedge clk) // Write
    begin
        if (MemWrite == 1) begin
            data[addr] <= write_data;
        end
    end

    always@(*) // Read
    begin
        if (MemWrite == 0) begin
            read_data = data[addr];
            $display("Read %d data = %d", addr, read_data);
        end
    end
endmodule