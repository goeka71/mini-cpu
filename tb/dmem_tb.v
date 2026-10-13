module tb;
    reg [15:0] addr, write_data;
    wire [15:0] read_data;
    reg MemWrite;
    reg clk = 0;

    dmem u1(.MemWrite(MemWrite), .addr(addr), .write_data(write_data), .clk(clk), .read_data(read_data));
    
    always #5 clk = ~clk;

    initial begin
        MemWrite = 1;
        addr = 16'b0000000000000001;
        write_data = 16'b0000000000000010;
        #10

        addr = 16'b0000000000000010;
        write_data = 16'b0000000000000100;
        #10

        MemWrite = 0;
        addr = 16'b0000000000000001;
        #10

        addr = 16'b0000000000000010;
        #10

        $finish;
    end
endmodule