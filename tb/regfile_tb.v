module tb;
    reg [2:0] r1_addr, r2_addr, rd_addr;
    reg [15:0] write_data;
    reg clk = 0;
    reg RegWrite;
    wire [15:0] o_1, o_2;

    regfile u1(.r1_addr(r1_addr), .r2_addr(r2_addr), .rd_addr(rd_addr), .write_data(write_data), .clk(clk), .RegWrite(RegWrite), .o_1(o_1), .o_2(o_2));
    
    always #5 clk = ~clk;

    initial begin
        RegWrite = 1;
        rd_addr = 16'b0000000000000001;
        write_data = 3'b011;
        $display("i_1 = %d, write_data = %d, RegWrite = %d", rd_addr, write_data, RegWrite);
        #10

        rd_addr = 3'b010;
        write_data = 16'b0000000000000100;
        $display("i_1 = %d, write_data = %d, RegWrite = %d", rd_addr, write_data, RegWrite);
        #10

        RegWrite = 0;
        r1_addr = 3'b001;
        r2_addr = 3'b010;
        $display("i_1 = %d, i_2 = %d, RegWrite = %d", r1_addr, r2_addr, RegWrite);
        #5
        $display("o_1 = %d, o_2 = %d", o_1, o_2);
        
        $finish;
    end
endmodule